#ifndef FLUTTER_PLUGIN_FLUTTER_OPENCC_FFI_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_OPENCC_FFI_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_opencc_ffi {

class FlutterOpenccFfiPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterOpenccFfiPlugin();

  virtual ~FlutterOpenccFfiPlugin();

  // Disallow copy and assign.
  FlutterOpenccFfiPlugin(const FlutterOpenccFfiPlugin&) = delete;
  FlutterOpenccFfiPlugin& operator=(const FlutterOpenccFfiPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_opencc_ffi

#endif  // FLUTTER_PLUGIN_FLUTTER_OPENCC_FFI_PLUGIN_H_
