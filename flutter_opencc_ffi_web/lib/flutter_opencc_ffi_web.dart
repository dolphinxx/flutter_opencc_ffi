import 'package:flutter_opencc_ffi_platform_interface/converter.dart';
import 'package:flutter_opencc_ffi_platform_interface/flutter_opencc_ffi_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter_opencc_ffi_web/src/converter_web.dart';

/// A web implementation of the FlutterOpenccFfiPlatform of the FlutterOpenccFfi plugin.
class FlutterOpenccFfiPlugin extends FlutterOpenccFfiPlatform {
  /// Constructs a FlutterOpenccFfiWeb
  FlutterOpenccFfiPlugin._();

  static void registerWith(Registrar registrar) {
    FlutterOpenccFfiPlatform.instance = FlutterOpenccFfiPlugin._();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Converter createConverter(String configFile) => ConverterWeb(configFile);
}
