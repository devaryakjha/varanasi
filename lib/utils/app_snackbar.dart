import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:varanasi_mobile_app/utils/helpers/get_app_context.dart';

class AppSnackbar {
  static Flushbar? flush;

  static Flushbar _createFlushBar(String message) {
    return flush = Flushbar(
      message: message,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(8),
      backgroundColor: Colors.white,
      messageColor: Colors.black,
      flushbarStyle: FlushbarStyle.FLOATING,
    );
  }

  /// Shows a [Flushbar] with the given [message] and [context].
  ///
  /// If [context] is not provided, [appContext] is used.
  static void show(String message, [BuildContext? context]) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      dismiss();
      context ??= appContext;
      _createFlushBar(message).show(context!);
    });
  }

  /// Dismisses the [Flushbar] if it is visible.
  /// If [context] is not provided, [appContext] is used.
  static Future<void> dismiss<T>([T? result]) {
    if (flush != null && flush!.isShowing()) {
      flush!.dismiss(result);
    }
    return Future.value();
  }
}
