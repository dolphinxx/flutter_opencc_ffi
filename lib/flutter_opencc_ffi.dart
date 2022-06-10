
import 'flutter_opencc_ffi_platform_interface.dart';

class FlutterOpenccFfi {
  Future<String?> getPlatformVersion() {
    return FlutterOpenccFfiPlatform.instance.getPlatformVersion();
  }
}
