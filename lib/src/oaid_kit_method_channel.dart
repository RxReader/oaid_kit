import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:oaid_kit/src/model/supplier.dart';
import 'package:oaid_kit/src/oaid_kit_platform_interface.dart';

/// An implementation of [OaidKitPlatform] that uses method channels.
class MethodChannelOaidKit extends OaidKitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel methodChannel =
      const MethodChannel('v7lin.github.io/oaid_kit');

  @override
  Future<Supplier> getOaid() async {
    assert(
        Platform.isAndroid || Platform.environment['FLUTTER_TEST'] == 'true');
    final Map<String, dynamic>? result =
        await methodChannel.invokeMapMethod<String, dynamic>('getOaid');
    return Supplier.fromJson(result!);
  }
}
