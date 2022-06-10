import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_opencc_ffi/flutter_opencc_ffi.dart';
import 'package:flutter_opencc_ffi/flutter_opencc_ffi_platform_interface.dart';
import 'package:flutter_opencc_ffi/flutter_opencc_ffi_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterOpenccFfiPlatform 
    with MockPlatformInterfaceMixin
    implements FlutterOpenccFfiPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterOpenccFfiPlatform initialPlatform = FlutterOpenccFfiPlatform.instance;

  test('$MethodChannelFlutterOpenccFfi is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterOpenccFfi>());
  });

  test('getPlatformVersion', () async {
    FlutterOpenccFfi flutterOpenccFfiPlugin = FlutterOpenccFfi();
    MockFlutterOpenccFfiPlatform fakePlatform = MockFlutterOpenccFfiPlatform();
    FlutterOpenccFfiPlatform.instance = fakePlatform;
  
    expect(await flutterOpenccFfiPlugin.getPlatformVersion(), '42');
  });
}
