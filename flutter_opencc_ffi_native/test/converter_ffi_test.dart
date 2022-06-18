import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_opencc_ffi_native/src/converter_ffi.dart';

void main() {
  test('illegal configFile', () async {
    dynamic error;
    try {
      ConverterFfi('abc/def.txt');
    } catch (e) {
      error = e;
    }
    expect(error, isA<ArgumentError>());
  });
  test('non existing configFile', () async {
    dynamic error;
    try {
      ConverterFfi('abc/def.json');
    } catch (e) {
      error = e;
    }
    expect(error, isA<ArgumentError>());
  });
  test('legal configFile', () async {
    dynamic error;
    try {
      ConverterFfi(Directory.current.uri.resolve('test/any.json').toFilePath()).type;
    } catch (e) {
      error = e;
    }
    expect(error, isA<ArgumentError>());
  });
}