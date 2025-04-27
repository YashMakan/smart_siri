import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_siri/smart_siri_platform_interface.dart';

/// An implementation of [SmartSiriPlatform] that uses method
/// and event channels.
class MethodChannelSmartSiri extends SmartSiriPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('smart-siri');

  /// The event channel used to receive interaction events from
  /// the native layer.
  @visibleForTesting
  final linksChannel = const EventChannel('smart-siri/links');

  /// Deserializes and notifies about selections made by the user
  /// in OS flows.
  @override
  Stream<String> selectionsStream() =>
      linksChannel.receiveBroadcastStream().map((item) => item.toString());

  @override
  Future<dynamic> backgroundResponse(String message) async {
    return await methodChannel.invokeMethod('backgroundResponse', message);
  }
}
