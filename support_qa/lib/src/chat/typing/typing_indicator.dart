import 'dart:async';

import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> {
  List<int> opacities = [0, 0, 0];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startAnimating();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startAnimating() {
    int index = 0;
    timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        opacities[index] = opacities[index] == 0 ? 1 : 0;
        index = (index + 1) % opacities.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 50.0, top: 8.0, bottom: 10.0), // Add padding to create space around the indicator
      child: Align(
        alignment: Alignment.centerLeft, // Align to the left like incoming messages
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.grey[300], // Match the color with your incoming message bubbles
            borderRadius: BorderRadius.circular(20), // Rounded corners for the bubble
          ),
          // A Row that contains the animated dots
          child: Row(
            mainAxisSize: MainAxisSize.min, // Use the minimum space necessary
            children: List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: AnimatedOpacity(
                  opacity: opacities[index].toDouble(),
                  duration: Duration(milliseconds: 200),
                  child: CircleAvatar(
                    radius: 4.0,
                    backgroundColor: Colors.blue, // Dot color, match this with your theme
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
