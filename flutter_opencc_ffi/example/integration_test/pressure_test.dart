import 'package:flutter_opencc_ffi_example/pressure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('performance test', (widgetTester) async {
    await runPressureForConvertString();
  });
}
