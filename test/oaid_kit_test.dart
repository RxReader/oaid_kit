import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oaid_kit/oaid_kit.dart';

void main() {
  const MethodChannel channel = MethodChannel('oaid_kit');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await OaidKit.platformVersion, '42');
  });
}
