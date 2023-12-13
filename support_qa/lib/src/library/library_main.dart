import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Major {
  final String name;
  final List<FileItem> files;

  Major({required this.name, required this.files});
}

class FileItem {
  final String fileName;
  final String fileIcon; // Đường dẫn đến icon của file
  final String dayLink;  // Đường dẫn đến ngày

  FileItem({required this.fileName, required this.fileIcon, required this.dayLink});
}

void main() {
  runApp(LibraryMain());
}

class LibraryMain extends StatelessWidget {
  const LibraryMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MajorsScreen(),
    );
  }
}

class MajorsScreen extends StatelessWidget {
  // Tạo một list các ngành học và files của chúng
  final List<Major> majors = [
    Major(
      name: 'Công nghệ thông tin',
      files: [
        FileItem(
          fileName: 'Laptrinhdiong.pdf',
          fileIcon: '/Users/Apple/Documents/GitHub/DATN/support_qa/assets/pdf_icon.png',
          dayLink: 'https://drive.google.com/file/d/1UU2RZti_7MZcvyHencMvF4nUn7taVEBO/view?usp=sharing',
        ),
        FileItem(
          fileName: 'tieng_anh.docx',
          fileIcon: '/Users/Apple/Documents/GitHub/DATN/support_qa/assets/word_icon.png',
          dayLink: 'https://docs.google.com/document/d/1FFrrrAHShG3J_5bmDvmk3ph8yvv8KSh8AWud2J6Gikg/edit?usp=sharing',
        ),
      ],
    ),
    // Thêm các ngành học khác
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn Ngành Học'),
        backgroundColor: const Color.fromARGB(255, 75, 174, 255),
      ),
      body: ListView.builder(
        itemCount: majors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(majors[index].name),
            onTap: () {
              // Khi người dùng chọn một ngành, chuyển đến màn hình hiển thị files của ngành đó
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilesScreen(major: majors[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FilesScreen extends StatelessWidget {
  final Major major;

  FilesScreen({required this.major});

  void openGoogleDriveLink(String fileLink) async {
    if (await canLaunch(fileLink)) {
      await launch(fileLink);
    } else {
      print("Không thể mở đường dẫn");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Files của ${major.name}'),
      ),
      body: ListView.builder(
        itemCount: major.files.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print("Đã bấm vào mục ${major.files[index].fileName}");
              openGoogleDriveLink(major.files[index].dayLink);
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    major.files[index].fileIcon,
                    width: 40,
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(major.files[index].fileName),
                      SizedBox(height: 4),
                    ],
                  ),
                  // Thêm các widgets khác nếu cần
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

