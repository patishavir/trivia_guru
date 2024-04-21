import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './logging_utils.dart';

Size getSize(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  LoggingUtils.writeLog("size: width=${size.width} height=${size.height}");
  return size;
}
const Color blue_255 = Color.fromARGB(255, 0, 0, 255);