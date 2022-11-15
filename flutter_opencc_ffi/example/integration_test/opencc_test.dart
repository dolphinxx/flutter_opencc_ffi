import 'package:flutter/foundation.dart';
import 'package:flutter_opencc_ffi/flutter_opencc_ffi.dart';
import 'package:flutter_opencc_ffi_example/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('convert s2tw', (widgetTester) async {
    String dataDir = await copyAssets();
    Converter opencc = createConverter('$dataDir/s2tw.json');
    String actual = opencc.convert('着装污染虚伪发泄棱柱群众里面');
    debugPrint(actual);
    expect(actual, "著裝汙染虛偽發洩稜柱群眾裡面");
  });
  testWidgets('convert tw2s', (widgetTester) async {
    String dataDir = await copyAssets();
    Converter opencc = createConverter('$dataDir/tw2s.json');
    String actual = opencc.convert('著裝汙染虛偽發洩稜柱群眾裡面');
    debugPrint(actual);
    expect(actual, "着装污染虚伪发泄棱柱群众里面");
  });
  testWidgets('convertList s2tw', (widgetTester) async {
    String dataDir = await copyAssets();
    Converter opencc = createConverter('$dataDir/s2tw.json');
    List<String> texts = ['着装污染虚伪发泄棱柱群众里面', '远看山有色', '近听水无声', '春去花还在', '人来鸟不惊'];
    List<String> actual = opencc.convertList(texts);
    debugPrint(actual.join('\n'));
    expect(actual, equals(["著裝汙染虛偽發洩稜柱群眾裡面", "遠看山有色", "近聽水無聲", "春去花還在", "人來鳥不驚"]));
  });
  testWidgets('convertList tw2s', (widgetTester) async {
    String dataDir = await copyAssets();
    Converter opencc = createConverter('$dataDir/tw2s.json');
    List<String> texts = ["著裝汙染虛偽發洩稜柱群眾裡面", "遠看山有色", "近聽水無聲", "春去花還在", "人來鳥不驚"];
    List<String> actual = opencc.convertList(texts);
    debugPrint(actual.join('\n'));
    expect(actual, equals(['着装污染虚伪发泄棱柱群众里面', '远看山有色', '近听水无声', '春去花还在', '人来鸟不惊']));
  });
}
