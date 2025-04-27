import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:smart_siri/smart_siri_method_channel.dart';

abstract class SmartSiriPlatform extends PlatformInterface {
  /// Constructs a SmartSiriPlatform.
  SmartSiriPlatform() : super(token: _token);

  static final Object _token = Object();

  static SmartSiriPlatform _instance = MethodChannelSmartSiri();

  /// The default instance of [SmartSiriPlatform] to use.
  ///
  /// Defaults to [MethodChannelSmartSiri].
  static SmartSiriPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SmartSiriPlatform] when
  /// they register themselves.
  static set instance(SmartSiriPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<String> selectionsStream() {
    throw UnimplementedError('selectedStream() has not been implemented.');
  }

  Future<dynamic> backgroundResponse(String message) {
    throw UnimplementedError('backgroundResponse() is not implemented.');
  }
}
