import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_opencc_ffi_platform_interface.dart';

/// An implementation of [FlutterOpenccFfiPlatform] that uses method channels.
class MethodChannelFlutterOpenccFfi extends FlutterOpenccFfiPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_opencc_ffi');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
