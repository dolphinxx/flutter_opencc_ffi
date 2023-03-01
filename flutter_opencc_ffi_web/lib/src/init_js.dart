import 'dart:js' as js;
import 'dart:html' as html;
import 'html.dart';

void initPlatform() {
  loadDictScripts();
  // initBundleData();
}

Future<void> loadDictScripts() async {
  if(js.context['OpenCCJSData'] != null) {
    return;
  }
  final opencc_prefix = 'https://cdn.jsdelivr.net/gh/dolphinxx/opencc_js_data@1.0.0/dist';
  html.ScriptElement base = createScriptTag('${opencc_prefix}/data.min.js');
  html.ScriptElement cn2t = createScriptTag('${opencc_prefix}/data.cn2t.min.js');
  html.ScriptElement t2cn = createScriptTag('${opencc_prefix}/data.t2cn.min.js');
  html.Element body = html.querySelector('body')!;
  body.append(base);
  body.append(cn2t);
  body.append(t2cn);
  await Future.wait([base.onLoad.first, cn2t.onLoad.first, t2cn.onLoad.first]);
}

// Future<void> initBundleData() async {
//   html.Element body = html.querySelector('body')!;
//   html.ScriptElement script = html.ScriptElement();
//   script.text = 'window.OpenCCJSData = {}';
//   script.type = 'text/javascript';
//   script.charset = 'utf-8';
//   body.append(script);
// }