import 'package:flutter_opencc_ffi_native/src/converter_ffi.dart';
import 'package:flutter_opencc_ffi_platform_interface/converter.dart';
import 'package:flutter_opencc_ffi_platform_interface/flutter_opencc_ffi_platform_interface.dart';

class FlutterOpenccFfi extends FlutterOpenccFfiPlatform {
  /// Registers this class as the default instance of [FlutterOpenccFfiPlatform].
  static void registerPlatform() {
    // Register the platform instance with the plugin platform
    // interface.
    FlutterOpenccFfiPlatform.instance = FlutterOpenccFfi._();
  }

  FlutterOpenccFfi._();

  @override
  Converter createConverter(String configFile) => ConverterFfi(configFile);
}
