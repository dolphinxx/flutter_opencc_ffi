import 'dart:js' as js;
import 'dart:html' as html;

html.ScriptElement createScriptTag(String url, {bool? async}) {
  html.ScriptElement script = html.ScriptElement()
    ..type = 'text/javascript'
    ..charset = 'utf-8'
    ..src = url;
  if(async == true) {
    script.async = true;
  }
  return script;
}