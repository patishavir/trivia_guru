import 'package:flutter/material.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:get/get.dart';

class GameOver extends StatelessWidget {
  const GameOver({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle ts = const TextStyle(
        fontFamily: 'Code128',
        fontSize: 90.0,
        backgroundColor: Colors.lightBlue,
        color: Colors.pinkAccent,
    );
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            color: Colors.lightBlueAccent,
            child: Align(
                alignment: Alignment.center,
              child: BlinkText(
                  'game_over'.tr,
                  style: const TextStyle(fontSize: 90.0, color: Colors.redAccent),
                  beginColor: Colors.black,
                  endColor: Colors.orange,
                  times: 10,
                  duration: const Duration(seconds: 1)
              ),
            ),
          ),
        ),
      ),
    );
  }
}
