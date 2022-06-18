import 'package:flutter/foundation.dart';
import 'package:flutter_opencc_ffi_native/flutter_opencc_ffi_native.dart';

void initPlatform() {
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows) {
    FlutterOpenccFfi.registerPlatform();
  }
}
