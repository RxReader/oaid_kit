import 'package:oaid_kit/src/model/supplier.dart';
import 'package:oaid_kit/src/oaid_kit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class OaidKitPlatform extends PlatformInterface {
  /// Constructs a OaidKitPlatform.
  OaidKitPlatform() : super(token: _token);

  static final Object _token = Object();

  static OaidKitPlatform _instance = MethodChannelOaidKit();

  /// The default instance of [OaidKitPlatform] to use.
  ///
  /// Defaults to [MethodChannelOaidKit].
  static OaidKitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OaidKitPlatform] when
  /// they register themselves.
  static set instance(OaidKitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Supplier> getOaid() {
    throw UnimplementedError('getOaid() has not been implemented.');
  }
}
