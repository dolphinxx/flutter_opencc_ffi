import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_opencc_ffi_platform_interface/converter.dart';
import 'package:flutter_test/flutter_test.dart';

class MockConverter extends Converter {
  MockConverter(String configFile) : super(configFile);
}

void main() {
  test('instantiate with configFile', () async {
    Converter converter = MockConverter(kIsWeb ? 'legal' : Platform.script.resolve('test/legal.json').toFilePath());
    expect(converter.type, 'legal');
  });
}
