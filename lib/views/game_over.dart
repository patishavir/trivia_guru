import 'package:flutter/material.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:get/get.dart';
import '../common/gui_utils.dart';

class GameOver extends StatelessWidget {
  String myText;
  GameOver({super.key, required this.myText});

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
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(20),
              color: blue_255,
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: BlinkText(myText.tr,
                    style:  TextStyle( fontSize:  MediaQuery.of(context).size.width/10,
                        fontWeight: FontWeight.bold, color: Colors.redAccent),
                    beginColor: Colors.grey.shade900,
                    endColor: Colors.white,
                    times: 5,
                    duration: const Duration(seconds: 1)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
