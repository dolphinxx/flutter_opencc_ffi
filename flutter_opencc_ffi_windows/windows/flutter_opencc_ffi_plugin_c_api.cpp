#include "include/flutter_opencc_ffi_windows/flutter_opencc_ffi_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_opencc_ffi_plugin.h"

void FlutterOpenccFfiPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_opencc_ffi::FlutterOpenccFfiPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
