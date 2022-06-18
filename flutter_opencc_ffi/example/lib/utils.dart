import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle, ByteData;
import 'package:path_provider/path_provider.dart';

Future<String> copyAssets() async {
  if(kIsWeb) {
    return '';
  }
  Directory dir = await getApplicationSupportDirectory();
  Directory openccDir = Directory('${dir.path}/opencc');
  if (openccDir.existsSync()) {
    return openccDir.path;
  }
  Directory tmp = Directory('${dir.path}/_opencc');
  if (tmp.existsSync()) {
    tmp.deleteSync(recursive: true);
  }
  tmp.createSync(recursive: true);
  List<String> assets = (await rootBundle.loadString('assets/opencc_assets.txt', cache: false)).split('\n');
  for (String f in assets) {
    File dest = File('${tmp.path}/$f');
    dest.createSync(recursive: true);
    ByteData data = await rootBundle.load('assets/opencc/$f');
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    dest.writeAsBytesSync(bytes);
  }
  tmp.renameSync(openccDir.path);
  return openccDir.path;
}