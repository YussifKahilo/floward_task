import 'dart:async';

import 'package:flutter/services.dart';

class NativeService {
  static const _platform = MethodChannel('com.example.profile/channel');

  static Future<void> sendFeedbackToNative(String message) async {
    try {
      await _platform.invokeMethod('sendFeedback', {'message': message});
    } catch (e, s) {
      Completer().completeError(e, s);
    }
  }
}
