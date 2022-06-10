import 'dart:io';
import 'package:path/path.dart' as path;


void main() {
  String dataDir = path.join(File(Platform.script.toFilePath()).parent.parent.path, 'assets', 'opencc');
  File(path.join(Directory(dataDir).parent.path, 'opencc_assets.txt')).writeAsStringSync(Directory(dataDir).listSync().map((f) => path.basename(f.path)).join('\n'));
}