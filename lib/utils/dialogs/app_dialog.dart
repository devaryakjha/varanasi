import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/utils/helpers/get_app_context.dart';

enum AppDialogAction {
  cancel,
  confirm;

  bool get isCancel => this == AppDialogAction.cancel;
  bool get isConfirm => this == AppDialogAction.confirm;
}

class AppDialog {
  AppDialog._();

  static final AppDialog _instance = AppDialog._();

  factory AppDialog() => _instance;

  static Widget _adaptiveAction({
    required BuildContext context,
    required VoidCallback onPressed,
    required Widget child,
    bool isDefaultAction = false,
    bool isDestructiveAction = false,
    TextStyle? textStyle,
  }) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(textStyle: textStyle),
          child: child,
        );
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(
          onPressed: onPressed,
          isDefaultAction: isDefaultAction,
          isDestructiveAction: isDestructiveAction,
          textStyle: textStyle,
          child: child,
        );
    }
  }

  static Future<T?> showAlertDialog<T>({
    BuildContext? context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String cancelLabel = 'Cancel',
    String confirmLabel = 'Yes',
    AppDialogAction defaultAction = AppDialogAction.cancel,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    TextStyle? cancelLabelStyle,
    TextStyle? confirmLabelStyle,
    T Function()? onWillPop,
  }) {
    return showAdaptiveDialog<T>(
      context: context ?? appContext,
      builder: (context) => AlertDialog.adaptive(
        title: Text(title, style: titleStyle),
        titleTextStyle: titleStyle,
        content: Text(message, style: messageStyle),
        contentTextStyle: messageStyle,
        actions: [
          _adaptiveAction(
            isDefaultAction: defaultAction.isCancel,
            context: context,
            onPressed: () {
              context.pop();
              onCancel?.call();
            },
            textStyle: cancelLabelStyle,
            child: Text(cancelLabel, style: cancelLabelStyle),
          ),
          _adaptiveAction(
            isDefaultAction: defaultAction.isConfirm,
            context: context,
            onPressed: () {
              context.pop(onWillPop?.call());
              onConfirm();
            },
            child: Text(confirmLabel, style: confirmLabelStyle),
            textStyle: confirmLabelStyle,
          ),
        ],
      ),
    );
  }
}
