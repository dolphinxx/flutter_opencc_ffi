import 'package:flutter_opencc_ffi_platform_interface/flutter_opencc_ffi_platform_interface.dart';
import 'package:flutter_opencc_ffi_platform_interface/converter.dart';
export 'package:flutter_opencc_ffi_platform_interface/converter.dart' show Converter;
import 'package:flutter_opencc_ffi/src/init_stub.dart'
    if (dart.library.io) 'package:flutter_opencc_ffi_native/src/init_native.dart'
    if (dart.library.js) 'package:flutter_opencc_ffi_web/src/init_js.dart';

bool _initialized = false;

Converter createConverter(String configFile) {
  if (!_initialized) {
    initPlatform();
    _initialized = true;
  }
  return FlutterOpenccFfiPlatform.instance.createConverter(configFile);
}
