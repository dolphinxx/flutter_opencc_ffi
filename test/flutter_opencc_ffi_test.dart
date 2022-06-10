import 'dart:io';

import 'package:flutter_opencc_ffi/flutter_opencc_ffi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('instantiate with non existing data dir', () async {
    dynamic error;
    try {
      FlutterOpenccFfi('');
    } catch (e) {
      error = e;
    }
    expect(error, isA<AssertionError>());
  });

  test('instantiate success', () async {
    dynamic error;
    try {
      FlutterOpenccFfi(Directory.current.path);
    } catch (e) {
      error = e;
    }
    expect(error, isNot(isA<AssertionError>()));
  });
}
