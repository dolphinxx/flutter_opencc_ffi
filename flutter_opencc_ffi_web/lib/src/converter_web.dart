import 'dart:js' as js;
import 'package:flutter_opencc_ffi_platform_interface/converter.dart';
import 'package:flutter_opencc_ffi_web/src/trie.dart';
import 'package:flutter_opencc_ffi_web/src/init_js.dart';
const dictConfigs = {
  'hk2s': [["HKVariantsRevPhrases","HKVariantsRev","TSPhrases","TSCharacters"], ["HKRev", "TS"]],
  'hk2t': [["HKVariantsRevPhrases","HKVariantsRev"], ["HKRev"]],
  'jp2t': [["JPShinjitaiPhrases","JPShinjitaiCharacters","JPVariantsRev"], ["JPShinjitai"]],
  's2hk': [["STPhrases","STCharacters","HKVariants"], ["ST","HKVariants"]],
  's2t': [["STPhrases","STCharacters"], ["ST"]],
  's2tw': [["STPhrases","STCharacters","TWVariants"], ["ST", "TWVariants"]],
  's2twp': [["STPhrases","STCharacters", "TWPhrasesIT", "TWPhrasesName", "TWPhrasesOther","TWVariants"], ["ST", "TWPhrases", "TWVariants"]],
  't2hk': [["HKVariants"], ["HKVariants"]],
  't2jp': [["JPVariants"], ["JPVariants"]],
  't2s': [["TSPhrases","TSCharacters"],["TS"]],
  't2tw': [["TWVariants"], ["TWVariants"]],
  'tw2s': [["TWVariantsRevPhrases","TWVariantsRev","TSPhrases","TSCharacters"], ["TWRev", "TS"]],
  'tw2sp': [["TWPhrasesRev","TWVariantsRevPhrases","TWVariantsRev","TSPhrases","TSCharacters"], ["TWPhrasesRev", "TWRev", "TS"]],
  'tw2t': [["TWVariantsRevPhrases","TWVariantsRev"], ["TWRev"]],
};
class ConverterWeb extends Converter {

  ConverterWeb(String configFile):super(configFile) {
    initPlatform();
  }

  String _getDict(dictName) {
    return js.JsObject.fromBrowserObject(js.context['OpenCCJSData'])[dictName];
  }

  Trie _loadDict(dictName) {
    final t = Trie();
    for(final tuple in _getDict(dictName).split('|')) {
      final s = tuple.split(' ');
      t.addWord(s[0], s[1]);
    }
    return t;
  }

  String _convert(String text, Iterable<Trie> dictList) {
    String result = text;
    for(final dict in dictList) {
      result = dict.convert(result);
    }
    return result;
  }

  /// For web, [configFile] is the [type]
  @override
  String getTypeFromConfigFile(String configFile) {
    return configFile;
  }

  @override
  String convert(String text) {
    final dictConfig = dictConfigs[type];
    if(dictConfig == null) {
      throw new ArgumentError('convert type[$type] not supported');
    }
    final dictList = dictConfig[0].map((dictName) => _loadDict(dictName));
    return _convert(text, dictList);
  }

  @override
  List<String> convertList(List<String> texts) {
    final dictConfig = dictConfigs[type];
    if(dictConfig == null) {
      throw new ArgumentError('convert type[$type] not supported');
    }
    final dictList = dictConfig[0].map((dictName) => _loadDict(dictName));
    return texts.map((text) => _convert(text, dictList)).toList();
  }
}