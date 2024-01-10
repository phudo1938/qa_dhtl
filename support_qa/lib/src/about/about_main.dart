import 'package:flutter/material.dart';

class AboutThuyLoi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Chat Q&A AI'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                    '/Users/Apple/Documents/GitHub/DATN/support_qa/assets/logo.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Chat Q&A AI là một trang website cũng cấp các thông tin về trường Đại học Thuỷ Lợi, nơi bạn có thể tìm kiếm các thông tin liên quan tới trường, đây là phiên bản thử nhiệm, tất cả đều được hỗ trợ phản hồi từ AI nên sẽ có thiếu sót. Có vấn đề gì hãy liên hệ với chúng tôi. ',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Contact Us',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('dophu1938@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('+0945521311'),
            ),
            // Bạn có thể thêm thêm các phần tử khác nếu muốn
          ],
        ),
      ),
    );
  }
}
