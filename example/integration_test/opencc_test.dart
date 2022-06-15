import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle, ByteData;
import 'package:flutter_opencc_ffi/flutter_opencc_ffi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider/path_provider.dart' show getApplicationSupportDirectory;

Future<String> copyAssets() async {
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

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('convert s2tw', (widgetTester) async {
    String dataDir = await copyAssets();
    FlutterOpenccFfi opencc = FlutterOpenccFfi('s2tw', dataDir);
    String actual = opencc.convert('着装污染虚伪发泄棱柱群众里面');
    debugPrint(actual);
    expect(actual, "著裝汙染虛偽發洩稜柱群眾裡面");
  });
  testWidgets('convert tw2s', (widgetTester) async {
    String dataDir = await copyAssets();
    FlutterOpenccFfi opencc = FlutterOpenccFfi('tw2s', dataDir);
    String actual = opencc.convert('著裝汙染虛偽發洩稜柱群眾裡面');
    debugPrint(actual);
    expect(actual, "着装污染虚伪发泄棱柱群众里面");
  });
  testWidgets('convertList s2tw', (widgetTester) async {
    String dataDir = await copyAssets();
    FlutterOpenccFfi opencc = FlutterOpenccFfi('s2tw', dataDir);
    List<String> texts = ['着装污染虚伪发泄棱柱群众里面', '远看山有色', '近听水无声', '春去花还在', '人来鸟不惊'];
    List<String> actual = opencc.convertList(texts);
    debugPrint(actual.join('\n'));
    expect(actual, equals(["著裝汙染虛偽發洩稜柱群眾裡面", "遠看山有色", "近聽水無聲", "春去花還在", "人來鳥不驚"]));
  });
  testWidgets('convertList tw2s', (widgetTester) async {
    String dataDir = await copyAssets();
    FlutterOpenccFfi opencc = FlutterOpenccFfi('tw2s', dataDir);
    List<String> texts = ["著裝汙染虛偽發洩稜柱群眾裡面", "遠看山有色", "近聽水無聲", "春去花還在", "人來鳥不驚"];
    List<String> actual = opencc.convertList(texts);
    debugPrint(actual.join('\n'));
    expect(actual, equals(['着装污染虚伪发泄棱柱群众里面', '远看山有色', '近听水无声', '春去花还在', '人来鸟不惊']));
  });
}
