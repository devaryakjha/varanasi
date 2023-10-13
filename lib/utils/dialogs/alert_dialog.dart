import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showAlertDialog(
  BuildContext context,
  String title,
  String message, {
  String? cancelLabel,
  String? confirmLabel,
  VoidCallback? onConfirm,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          onPressed: () => context.pop(),
          child: Text(cancelLabel ?? 'Cancel'),
        ),
        TextButton(
          onPressed: () {
            context.pop(true);
            onConfirm!();
          },
          child: Text(confirmLabel ?? 'Yes'),
        ),
      ],
    ),
  );
}
