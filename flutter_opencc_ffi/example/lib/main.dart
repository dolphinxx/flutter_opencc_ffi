import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_opencc_ffi/flutter_opencc_ffi.dart';
import 'package:flutter_opencc_ffi_example/pressure.dart';
import 'package:flutter_opencc_ffi_example/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey();
  final List<String> types = ["s2t", "t2s", "s2hk", "hk2s", "s2tw", "tw2s", "s2twp", "tw2sp", "t2hk", "hk2t", "t2jp", "jp2t", "t2tw", "tw2t"];
  late final Map<String, Converter> converters = {};
  late final TextEditingController textEditingController;
  final List<bool> originSelections = [true, false, false];
  final List<String> originTypes = ['s', 't', 'jp'];
  final List<bool> targetSelections = [false, true, false];
  final List<String> targetTypes = ['s', 't', 'jp'];
  final List<bool> variantSelections = [true, false, false];
  final List<String> variantTypes = ['', 'w', 'hk'];
  final List<bool> idiomSelections = [true, false, false];
  final List<String> idiomTypes = ['', '', 'p'];
  bool initialized = false;
  String result = '';
  String error = '';
  String type = '';
  bool runningPressureTest = false;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(
        text: '''
夸夸其谈 夸父逐日
我干什么不干你事。
太后的头发很干燥。
燕燕于飞，差池其羽。之子于归，远送于野。
请成相，世之殃，愚暗愚暗堕贤良。人主无贤，如瞽无相何伥伥！请布基，慎圣人，愚而自专事不治。主忌苟胜，群臣莫谏必逢灾。
曾经有一份真诚的爱情放在我面前，我没有珍惜，等我失去的时候我才后悔莫及。人事间最痛苦的事莫过于此。如果上天能够给我一个再来一次得机会，我会对那个女孩子说三个字，我爱你。如果非要在这份爱上加个期限，我希望是，一万年。
新的理论被发现了。
金胄不是金色的甲胄。
经理发现后劝谕两人
想到自己一紧张就口吃，我就没胃口吃饭
'''
            .trim());
    type = getType();
    copyAssets().then((dataDir) {
      for (String type in types) {
        converters[type] = createConverter(kIsWeb ? type : '$dataDir/$type.json');
      }
      if (mounted) {
        setState(() {
          initialized = true;
        });
      }
    });
  }

  String joinOriginTypes(String origin, String variant, String idiom) {
    if (origin == 's' || origin == 'jp') {
      return origin;
    }
    if (variant == 'hk') {
      return variant;
    }
    // t, tw, twp
    return '$origin$variant$idiom';
  }

  String joinTargetTypes(String target, String variant, String idiom) {
    if (target == 'jp') {
      return target;
    }
    if (target == 's') {
      // s, sp
      return '$target$idiom';
    }
    if (variant == 'hk') {
      return variant;
    }
    // t, tw, twp
    return '$target$variant$idiom';
  }

  String getType() {
    String originType = originTypes[originSelections.indexWhere((element) => element)];
    String targetType = targetTypes[targetSelections.indexWhere((element) => element)];
    String variantType = variantTypes[variantSelections.indexWhere((element) => element)];
    String idiomType = idiomTypes[idiomSelections.indexWhere((element) => element)];
    String origin = joinOriginTypes(originType, variantType, idiomType);
    String target = joinTargetTypes(targetType, variantType, idiomType);
    String type = '${origin}2$target';
    return type;
  }

  void convert() {
    String source = textEditingController.text;
    if (!types.contains(type)) {
      return;
    }
    if (mounted) {
      setState(() {
        result = converters[type]!.convert(source);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const gutter = Padding(
      padding: EdgeInsets.only(top: 6, left: 6),
    );
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('開放中文轉換 (Open Chinese Convert)'),
          actions: [
            ElevatedButton(
              onPressed: runningPressureTest ? null : () {
                setState(() {
                  runningPressureTest = true;
                });
                runPressureForConvertList().whenComplete(() {
                  if(mounted) {
                    setState(() {
                      runningPressureTest = false;
                    });
                  }
                });
              },
                child: runningPressureTest ? const CircularProgressIndicator() : const Text('Pressure'),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('原文'),
                  gutter,
                  Expanded(
                    child: ToggleButtons(
                      isSelected: originSelections,
                      onPressed: (int index) {
                        for (int i = 0; i < originSelections.length; i++) {
                          originSelections[i] = i == index ? true : false;
                        }
                        if (mounted) {
                          setState(() {
                            type = getType();
                          });
                        }
                      },
                      children: const [
                        Text('簡體中文'),
                        Text('繁體中文'),
                        Text('日文新字體'),
                      ],
                    ),
                  ),
                ],
              ),
              gutter,
              Row(
                children: [
                  const Text('目標'),
                  gutter,
                  Expanded(
                    child: ToggleButtons(
                      isSelected: targetSelections,
                      onPressed: (int index) {
                        for (int i = 0; i < targetSelections.length; i++) {
                          targetSelections[i] = i == index ? true : false;
                        }
                        if (mounted) {
                          setState(() {
                            type = getType();
                          });
                        }
                      },
                      children: const [
                        Text('簡體中文'),
                        Text('繁體中文'),
                        Text('日文新字體'),
                      ],
                    ),
                  ),
                ],
              ),
              gutter,
              Row(
                children: [
                  const Text('異體字轉換'),
                  gutter,
                  Expanded(
                    child: ToggleButtons(
                      isSelected: variantSelections,
                      onPressed: (int index) {
                        for (int i = 0; i < variantSelections.length; i++) {
                          variantSelections[i] = i == index ? true : false;
                        }
                        if (mounted) {
                          setState(() {
                            type = getType();
                          });
                        }
                      },
                      children: const [
                        Text('OpenCC標準'),
                        Text('臺灣標準'),
                        Text('香港標準'),
                      ],
                    ),
                  ),
                ],
              ),
              gutter,
              Row(
                children: [
                  const Text('地域用詞轉換'),
                  gutter,
                  Expanded(
                    child: ToggleButtons(
                      isSelected: idiomSelections,
                      onPressed: (int index) {
                        for (int i = 0; i < idiomSelections.length; i++) {
                          idiomSelections[i] = i == index ? true : false;
                        }
                        if (mounted) {
                          setState(() {
                            type = getType();
                          });
                        }
                      },
                      children: const [
                        Text('不轉換'),
                        Text('中國大陸模式'),
                        Text('臺灣模式'),
                      ],
                    ),
                  ),
                ],
              ),
              gutter,
              Text(
                type,
                style: TextStyle(color: types.contains(type) ? Colors.green : Colors.red),
              ),
              gutter,
              TextField(
                controller: textEditingController,
                maxLines: 6,
              ),
              gutter,
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                ),
                padding: const EdgeInsets.all(6),
                child: Text(result, softWrap: true),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: convert,
          child: const Icon(Icons.translate),
        ),
      ),
    );
  }
}
