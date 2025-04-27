import 'dart:async';
import 'dart:typed_data';

import 'smart_siri_platform_interface.dart';

typedef BackgroundSuccessCallback = Future<void> Function(dynamic);

class SmartSiri {
  BackgroundSuccessCallback? _onSuccess;

  SmartSiri([this._onSuccess]);

  BackgroundSuccessCallback? get onSuccess => _onSuccess;

  void setOnSuccess(BackgroundSuccessCallback callback) {
    _onSuccess = callback;
  }

  Stream<String> selectionsStream() =>
      SmartSiriPlatform.instance.selectionsStream();

  Future<void> backgroundResponse(String message) async {
    if(_onSuccess != null) {
      await _onSuccess?.call(message);
    } else {
      await SmartSiriPlatform.instance.backgroundResponse(message);
    }
  }

  Future<void> backgroundResponseUint8List(Uint8List data) async {
    if(_onSuccess != null) {
      await _onSuccess?.call(data);
    }
  }
}
