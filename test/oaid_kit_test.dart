import 'package:flutter_test/flutter_test.dart';
import 'package:oaid_kit/src/model/supplier.dart';
import 'package:oaid_kit/src/oaid.dart';
import 'package:oaid_kit/src/oaid_kit_method_channel.dart';
import 'package:oaid_kit/src/oaid_kit_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockOaidKitPlatform
    with MockPlatformInterfaceMixin
    implements OaidKitPlatform {
  @override
  Future<Supplier> getOaid() {
    return Future<Supplier>.value(Supplier(
      isSupported: false,
    ));
  }
}

void main() {
  final OaidKitPlatform initialPlatform = OaidKitPlatform.instance;

  test('$MethodChannelOaidKit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOaidKit>());
  });

  test('getOaid', () async {
    final MockOaidKitPlatform fakePlatform = MockOaidKitPlatform();
    OaidKitPlatform.instance = fakePlatform;

    final Supplier supplier = await Oaid.instance.getOaid();
    expect(supplier.isSupported, false);
  });
}
