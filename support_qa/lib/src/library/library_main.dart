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
      name: 'Sổ tay sinh viên năm học 2022-2023',
      files: [
        FileItem(
          fileName: 'quy_dinh_ve_chuan_dau_ra.pdf',
          fileIcon: '/Users/Apple/Documents/GitHub/DATN/support_qa/assets/pdf_icon.png',
          dayLink: 'https://drive.google.com/file/d/1zlbQRFJiMzNL29uHKY7HrfrAezhzYkR7/view?usp=sharing',
        ),
        FileItem(
          fileName: 'quy_che_dao_tao.docx',
          fileIcon: '/Users/Apple/Documents/GitHub/DATN/support_qa/assets/word_icon.png',
          dayLink: 'https://docs.google.com/document/d/19WNz9g9rThWn0ekrfkIFERGU1ccUyYHj/edit?usp=sharing&ouid=112167676018090175261&rtpof=true&sd=true',
        ),
        FileItem(
          fileName: 'qd_ve_tieng_anh.docx',
          fileIcon: '/Users/Apple/Documents/GitHub/DATN/support_qa/assets/word_icon.png',
          dayLink: 'https://docs.google.com/document/d/1WbGPAvU2xBjzWZBs10gZWWF1bfvMPrGv/edit?usp=sharing&ouid=112167676018090175261&rtpof=true&sd=true',
        ),
        FileItem(
          fileName: 'ngoai_tru.docx',
          fileIcon: '/Users/Apple/Documents/GitHub/DATN/support_qa/assets/word_icon.png',
          dayLink: 'https://docs.google.com/document/d/1mgg089nOpA0Ozvlzp4_4CYY0MKgFYpuz/edit?usp=sharing&ouid=112167676018090175261&rtpof=true&sd=true',
        ),
        FileItem(
          fileName: 'hoc_phi.docx',
          fileIcon: '/Users/Apple/Documents/GitHub/DATN/support_qa/assets/word_icon.png',
          dayLink: 'https://docs.google.com/document/d/1xtmqXaHG8CpkWxgEcJ7mkSs5-wseg_rf/edit?usp=sharing&ouid=112167676018090175261&rtpof=true&sd=true',
        ),
        FileItem(
          fileName: 'hoc_bong.docx',
          fileIcon: '/Users/Apple/Documents/GitHub/DATN/support_qa/assets/word_icon.png',
          dayLink: 'https://docs.google.com/document/d/1GphFTExvSMRKAWBAr4zGoRUwnq59N1PJ/edit?usp=sharing&ouid=112167676018090175261&rtpof=true&sd=true',
        ),
      ],
    ),
    Major(
      name: 'Sổ tay sinh viên năm học 2023-2024',
      files: [
        FileItem(
          fileName: 'quy_dinh_ve_chuan_dau_ra.pdf',
          fileIcon: '/Users/Apple/Documents/GitHub/DATN/support_qa/assets/pdf_icon.png',
          dayLink: 'https://drive.google.com/file/d/1zlbQRFJiMzNL29uHKY7HrfrAezhzYkR7/view?usp=sharing',
        ),
        FileItem(
          fileName: 'quy_che_dao_tao.docx',
          fileIcon: '/Users/Apple/Documents/GitHub/DATN/support_qa/assets/word_icon.png',
          dayLink: 'https://docs.google.com/document/d/19WNz9g9rThWn0ekrfkIFERGU1ccUyYHj/edit?usp=sharing&ouid=112167676018090175261&rtpof=true&sd=true',
        ),
        FileItem(
          fileName: 'qd_ve_tieng_anh.docx',
          fileIcon: '/Users/Apple/Documents/GitHub/DATN/support_qa/assets/word_icon.png',
          dayLink: 'https://docs.google.com/document/d/1WbGPAvU2xBjzWZBs10gZWWF1bfvMPrGv/edit?usp=sharing&ouid=112167676018090175261&rtpof=true&sd=true',
        ),
        FileItem(
          fileName: 'ngoai_tru.docx',
          fileIcon: '/Users/Apple/Documents/GitHub/DATN/support_qa/assets/word_icon.png',
          dayLink: 'https://docs.google.com/document/d/1mgg089nOpA0Ozvlzp4_4CYY0MKgFYpuz/edit?usp=sharing&ouid=112167676018090175261&rtpof=true&sd=true',
        ),
        FileItem(
          fileName: 'hoc_phi.docx',
          fileIcon: '/Users/Apple/Documents/GitHub/DATN/support_qa/assets/word_icon.png',
          dayLink: 'https://docs.google.com/document/d/1xtmqXaHG8CpkWxgEcJ7mkSs5-wseg_rf/edit?usp=sharing&ouid=112167676018090175261&rtpof=true&sd=true',
        ),
        FileItem(
          fileName: 'hoc_bong.docx',
          fileIcon: '/Users/Apple/Documents/GitHub/DATN/support_qa/assets/word_icon.png',
          dayLink: 'https://docs.google.com/document/d/1GphFTExvSMRKAWBAr4zGoRUwnq59N1PJ/edit?usp=sharing&ouid=112167676018090175261&rtpof=true&sd=true',
        ),
      ],
    ),
    // Thêm các ngành học khác
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tài Liệu'),
        backgroundColor: const Color.fromARGB(255, 75, 174, 255),
      ),
      body: ListView.builder(
        itemCount: majors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(majors[index].name),
            onTap: () {
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

