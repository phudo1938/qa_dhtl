import 'package:flutter/material.dart';

class Major {
  final String name;
  final List<FileItem> files;

  Major({required this.name, required this.files});
}

class FileItem {
  final String fileName;
  final String fileIcon; // Đường dẫn đến icon của file

  FileItem({required this.fileName, required this.fileIcon});
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
      name: 'Computer Science',
      files: [
        FileItem(fileName: 'Lecture 1.pdf', fileIcon: 'icons/pdf_icon.png'),
        // Thêm các files khác
      ],
    ),
    // Thêm các ngành học khác
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn Ngành Học'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Files của ${major.name}'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Số lượng cột
          // Thêm các thuộc tính khác như crossAxisSpacing, mainAxisSpacing,...
        ),
        itemCount: major.files.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: <Widget>[
                Image.asset(major.files[index].fileIcon),
                Text(major.files[index].fileName),
                // Thêm các widgets khác nếu cần
              ],
            ),
          );
        },
      ),
    );
  }
}
