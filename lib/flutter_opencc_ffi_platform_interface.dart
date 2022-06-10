import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_opencc_ffi_method_channel.dart';

abstract class FlutterOpenccFfiPlatform extends PlatformInterface {
  /// Constructs a FlutterOpenccFfiPlatform.
  FlutterOpenccFfiPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterOpenccFfiPlatform _instance = MethodChannelFlutterOpenccFfi();

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

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
