import 'dart:io';
import 'package:path/path.dart' as p;

Future<String> readFile(String relativePath) async {
  var filePath = p.join(Directory.current.path, relativePath);
  File file = File(filePath);
  var fut = await file.readAsString();
  return fut;
}
