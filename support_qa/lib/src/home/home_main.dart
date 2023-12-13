import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int backgroundIndex = 0;
  List<String> backgroundImages = [
    "/Users/Apple/Documents/GitHub/DATN/support_qa/assets/home_1.png",
    "/Users/Apple/Documents/GitHub/DATN/support_qa/assets/home_2.png",
    "/Users/Apple/Documents/GitHub/DATN/support_qa/assets/home_3.png",
    "/Users/Apple/Documents/GitHub/DATN/support_qa/assets/home_4.png",
    "/Users/Apple/Documents/GitHub/DATN/support_qa/assets/home_5.png",
    "/Users/Apple/Documents/GitHub/DATN/support_qa/assets/home_6.png",
    "/Users/Apple/Documents/GitHub/DATN/support_qa/assets/home_7.png",
    // Thêm các đường dẫn ảnh khác nếu cần
  ];

  late Timer timer;

  @override
  void initState() {
    super.initState();
    startImageTimer();
  }

  void startImageTimer() {
    const Duration changeDuration = Duration(seconds: 3); // Đặt thời gian giữa các lần chuyển đổi
    timer = Timer.periodic(changeDuration, (timer) {
      changeBackgroundOnTimer();
    });
  }

  void changeBackgroundOnTimer() {
    setState(() {
      backgroundIndex = (backgroundIndex + 1) % backgroundImages.length;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImages[backgroundIndex]),
            fit: BoxFit.fill,
          ),
        ),
        curve: Curves.easeInOut,
        child: MouseRegion(
          onEnter: (_) {
            startImageTimer();
          },
          onExit: (_) {
            timer.cancel();
          },
        ),
      ),
    );
  }
}
