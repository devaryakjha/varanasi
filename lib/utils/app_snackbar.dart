import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/utils/helpers/get_app_context.dart';

class AppSnackbar {
  static Flushbar _createFlushBar(String message) => Flushbar(
        message: message,
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 500),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        borderRadius: BorderRadius.circular(8),
        backgroundColor: Colors.white,
        messageColor: Colors.black,
        flushbarStyle: FlushbarStyle.FLOATING,
      );

  /// Shows a [Flushbar] with the given [message] and [context].
  ///
  /// If [context] is not provided, [appContext] is used.
  static void show(String message, [BuildContext? context]) {
    context ??= appContext;
    _createFlushBar(message).show(context);
  }
}
