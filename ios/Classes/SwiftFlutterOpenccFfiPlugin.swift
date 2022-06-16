import Flutter
import UIKit

public class SwiftFlutterOpenccFfiPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_opencc_ffi", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterOpenccFfiPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
    let dummy = opencc_dummy_method_to_enforce_bundling()
    print(dummy)
  }
}
