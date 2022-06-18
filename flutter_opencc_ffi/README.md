# flutter_opencc_ffi

A Flutter plugin for conversion between Traditional and Simplified Chinese.

This plugin is based on [BYVoid/OpenCC](https://github.com/BYVoid/OpenCC), and calls native methods through ffi.

The web platform implementation is based on [nk2028/opencc-js](https://github.com/nk2028/opencc-js).

## Getting Started

To use this plugin, you need to provide opencc data directory.

You can download them at runtime or bundle them in assets and extract to filesystem at runtime.

See the example for how to extract data from assets.

For web platform, the opencc data is currently bundled to the plugin.

```dart
import 'package:flutter_opencc_ffi/flutter_opencc_ffi.dart';
// non web platform
Converter converter = createConverter('<path to config file>');
// eg
Converter converter = createConverter('<some dir>/opencc/s2tw.json');
// web platform
Converter converter = createConverter('<type>');
// eg:
Converter converter = createConverter('s2tw');

String result = converter.convert('着装污染虚伪发泄棱柱群众里面');
// result: 著裝汙染虛偽發洩稜柱群眾裡面
List<String> result = converter.convertList(['着装污染虚伪发泄棱柱群众里面', '鲶鱼和鲇鱼是一种生物。']);
// result: ['著裝汙染虛偽發洩稜柱群眾裡面', '鯰魚和鯰魚是一種生物。']

converter.dispose();
```