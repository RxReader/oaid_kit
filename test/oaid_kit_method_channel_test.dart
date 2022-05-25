import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oaid_kit/src/model/supplier.dart';
import 'package:oaid_kit/src/oaid_kit_method_channel.dart';

void main() {
  final MethodChannelOaidKit platform = MethodChannelOaidKit();
  const MethodChannel channel = MethodChannel('v7lin.github.io/oaid_kit');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'getOaid':
          return Supplier(
            isSupported: false,
          ).toJson();
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getOaid', () async {
    final Supplier supplier = await platform.getOaid();
    expect(supplier.isSupported, false);
  });
}
