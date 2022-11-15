import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter_opencc_ffi_example/opencc_isolate.dart';

Future<void> runPressureForConvertString() async {
  ChineseConvert convert = ChineseConvert.instance;
  await convert.init();
  String data1 = await rootBundle.loadString('assets/test_data01.txt');
  String data2 = await rootBundle.loadString('assets/test_data02.txt');
  String data3 = await rootBundle.loadString('assets/test_data03.txt');
  List<String> data = [data1, data2, data3];
  Completer completer = Completer();
  int taskCount = 0;
  Future<void> runTest() async {
    taskCount++;
    for (int i = 0; i < 999; i++) {
      await convert.convert(data[i % 3], 's2tw');
      debugPrint('$i');
      await Future.delayed(const Duration(microseconds: 1));
    }
    if(--taskCount == 0) {
      completer.complete();
    }
  }
  runTest();
  runTest();
  runTest();
  runTest();
  runTest();
  runTest();
  runTest();
  runTest();
  await completer.future;
  convert.stopIsolate();
}

Future<void> runPressureForConvertList() async {
  ChineseConvert convert = ChineseConvert.instance;
  await convert.init();
  String data1 = await rootBundle.loadString('assets/test_data01.txt');
  String data2 = await rootBundle.loadString('assets/test_data02.txt');
  String data3 = await rootBundle.loadString('assets/test_data03.txt');
  List<List<String>> data = [data1, data2, data3].map((_) => _.split('\n')).toList();
  Completer completer = Completer();
  int taskCount = 4;
  Future<void> runTest() async {
    for (int i = 0; i < 999; i++) {
      await convert.convertList(data[i % 3], 's2tw');
      debugPrint('$i');
      await Future.delayed(const Duration(microseconds: 1));
    }
    if(--taskCount == 0) {
      completer.complete();
    }
  }
  runTest();
  runTest();
  runTest();
  runTest();
  await completer.future;
  convert.stopIsolate();
}