# flutter_opencc_ffi

A Flutter plugin for conversion between Traditional and Simplified Chinese.

## Getting Started

To use this plugin, you need to provide opencc data directory.

You can download them at runtime or bundle them in assets and extract to filesystem at runtime.

See the example for how to extract data from assets.

## Known issues

1. `was built for newer iOS version (xx) than being linked (xx)`

Add `-w` to Target > Build Settings > Other Linker Flags

2. `The 'Pods-Runner' target has transitive dependencies that include statically linked binaries: (/**/ios/Pods/LibOpenCCiOS/libopencc.a)`

Comment out `use_frameworks!` in Podfile, that is

```
- use_frameworks!
+ #use_frameworks!
```