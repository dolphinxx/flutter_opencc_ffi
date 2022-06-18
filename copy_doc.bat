@echo off

cd /D "%~dp0"

for %%t in (flutter_opencc_ffi,flutter_opencc_ffi_platform_interface,flutter_opencc_ffi_native,flutter_opencc_ffi_android,flutter_opencc_ffi_ios,flutter_opencc_ffi_macos,flutter_opencc_ffi_web,flutter_opencc_ffi_windows)  do (for %%f in (LICENSE,CHANGELOG.md) do copy .\%%f .\%%t\ /Y)