
import 'dart:async';
import 'dart:isolate';

import 'package:flutter_opencc_ffi/flutter_opencc_ffi.dart';
import 'package:flutter_opencc_ffi_example/utils.dart';
import 'package:logger/logger.dart';

class ChineseConvert {
  Isolate? _isolate;
  ReceivePort? _receivePort;
  /// sending message to isolate
  late SendPort _sendPort;

  int _isolateInitializeState = 0;
  int _openccInitializeState = 0;

  int _completerNextId = 1;
  int get completerNextId {
    if(_completerNextId > 10000) {
      _completerNextId = 1;
    }
    return _completerNextId++;
  }
  final Map<int, Completer<dynamic>> _completerMap = {};
  Completer<void>? _initializedCompleter;

  Logger logger = Logger();

  static ChineseConvert instance = ChineseConvert._();

  ChineseConvert._();

  Future<void> init() async {
    _initializedCompleter ??= Completer();
    bool doingInit = _isolateInitializeState == 0 || _openccInitializeState == 0;
    if(_isolateInitializeState == 0) {
      _isolateInitializeState = 1;
      try {
        await _initIsolate();
        _isolateInitializeState = 2;
      } catch (e) {
        logger.e('failed to initialize chinese convert isolate', e);
        _isolateInitializeState = 0;
      }
    }
    if(_openccInitializeState == 0) {
      _openccInitializeState = 1;
      try {
        await _initOpenCC();
        _openccInitializeState = 2;
      } catch (e) {
        logger.e('failed to initialize chinese convert OpenCC', e);
        _openccInitializeState = 0;
      }
    }
    if(doingInit && _isolateInitializeState == 2 && _openccInitializeState == 2 && !_initializedCompleter!.isCompleted) {
      _initializedCompleter!.complete();
    }
    if(!doingInit) {
      await _initializedCompleter!.future;
    }
  }

  Future<void> _initIsolate() async {
    Completer<void> _entryCompleter = Completer();
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_entryPoint, _receivePort!.sendPort);
    _receivePort!.listen((message) async {
      if (message is SendPort) {
        _sendPort = message;
        _entryCompleter.complete();
        return;
      }
      int completerId = message[#id];
      Symbol event = message[#event];
      if(event == #initResult || event == #convertResult || event == #convertListResult) {
        Completer completer = _completerMap.remove(completerId)!;
        if(message[#error] != null) {
          completer.completeError(message[#error]);
        } else {
          completer.complete(message[#result]);
        }
        return;
      }
      throw 'unknown event $event from spawned isolate';
    });
    return _entryCompleter.future;
  }

  static void _entryPoint(SendPort callerSendPort) {
    ReceivePort receivePort = ReceivePort();
    callerSendPort.send(receivePort.sendPort);

    Map<String, Converter> converters = {};
    String? dataDir;

    receivePort.listen((msg) async {
      Symbol event = msg[#event];
      int? completerId = msg[#id];
      if(event == #init) {
        dataDir = msg[#dataDir];
        Map<Symbol, dynamic> result = {
          #event: #initResult,
          #id: completerId,
        };
        callerSendPort.send(result);
        return;
      }
      if(event == #convert) {
        String type = msg[#type];
        Converter converter = converters.putIfAbsent(type, () => createConverter('$dataDir/$type.json'));
        String input = msg[#input];
        Map<Symbol, dynamic> result = {
          #event: #convertResult,
          #id: completerId,
        };
        try {
          String output = converter.convert(input);
          result[#result] = output;
        } catch (e) {
          result[#error] = e.toString();
        }
        callerSendPort.send(result);
        return;
      }
      if(event == #convertList) {
        String type = msg[#type];
        Converter converter = converters.putIfAbsent(type, () => createConverter('$dataDir/$type.json'));
        List<String> input = msg[#input];
        Map<Symbol, dynamic> result = {
          #event: #convertListResult,
          #id: completerId,
        };
        try {
          List<String> output = converter.convertList(input);
          result[#result] = output;
        } catch (e) {
          result[#error] = e.toString();
        }
        callerSendPort.send(result);
        return;
      }
    });
  }

  void stopIsolate() {
    _isolate?.kill(priority: Isolate.immediate);
    _initializedCompleter = null;
    _isolateInitializeState = 0;
    _openccInitializeState = 0;
  }

  Future<void> _initOpenCC() async {
    int completerId = completerNextId;
    Completer<void> completer = Completer();
    _completerMap[completerId] = completer;
    String dataDir = await copyAssets();
    _sendPort.send({#event: #init, #id: completerId, #dataDir: dataDir});
    return completer.future;
  }

  Future<String> convert(String raw, String type) async {
    await _initializedCompleter!.future;
    int completerId = completerNextId;
    Completer<String> completer = Completer();
    _completerMap[completerId] = completer;
    _sendPort.send({#event: #convert, #id: completerId, #type: type, #input: raw});
    return completer.future;
  }

  Future<List<String>> convertList(List<String> raw, String type) async {
    await _initializedCompleter!.future;
    int completerId = completerNextId;
    Completer<List<String>> completer = Completer();
    _completerMap[completerId] = completer;
    _sendPort.send({#event: #convertList, #id: completerId, #type: type, #input: raw});
    return completer.future;
  }
}