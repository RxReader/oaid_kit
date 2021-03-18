import 'dart:async';

import 'package:flutter/services.dart';
import 'package:oaid_kit/src/model/supplier.dart';

class Oaid {
  const Oaid._();

  static const MethodChannel _channel =
      MethodChannel('v7lin.github.io/oaid_kit');

  static Future<Supplier> getOaid() async {
    final Map<String, dynamic>? result =
        await _channel.invokeMapMethod<String, dynamic>('getOaid');
    return Supplier.fromJson(result!);
  }
}
