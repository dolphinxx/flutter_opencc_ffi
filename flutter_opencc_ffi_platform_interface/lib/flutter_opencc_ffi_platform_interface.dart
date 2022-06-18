import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:flutter_opencc_ffi_platform_interface/converter.dart';

abstract class FlutterOpenccFfiPlatform extends PlatformInterface {

  /// Constructs a FlutterOpenccFfiPlatform.
  FlutterOpenccFfiPlatform() : super(token: _token);

  static final Object _token = Object();

  static late FlutterOpenccFfiPlatform _instance;

  /// The default instance of [FlutterOpenccFfiPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterOpenccFfi].
  static FlutterOpenccFfiPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterOpenccFfiPlatform] when
  /// they register themselves.
  static set instance(FlutterOpenccFfiPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Converter createConverter(String configFile);
}
