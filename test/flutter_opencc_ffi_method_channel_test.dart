import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_opencc_ffi/flutter_opencc_ffi_method_channel.dart';

void main() {
  MethodChannelFlutterOpenccFfi platform = MethodChannelFlutterOpenccFfi();
  const MethodChannel channel = MethodChannel('flutter_opencc_ffi');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
