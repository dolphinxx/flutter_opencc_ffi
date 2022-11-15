#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_opencc_ffi.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_opencc_ffi_ios'
  s.version          = '0.0.3'
  s.summary          = 'A Flutter plugin for conversion between Traditional and Simplified Chinese.'
  s.description      = <<-DESC
A Flutter plugin for conversion between Traditional and Simplified Chinese.
                       DESC
  s.homepage         = 'https://github.com/dolphinxx/flutter_opencc_ffi/tree/main/flutter_opencc_ffi_ios'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Dolphinxx' => 'bravedolphinxx@gmail.com' }
  s.source           = { :path => '.' }
  s.public_header_files = 'Classes/**/*.h'
  s.source_files = 'Classes/**/*.{h,m,swift}'
  s.dependency 'Flutter'
  s.dependency 'LibOpenCCiOS','0.0.3'
  #s.libraries = 'c++'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO', 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
