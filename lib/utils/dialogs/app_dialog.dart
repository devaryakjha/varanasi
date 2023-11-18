import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/helpers/get_app_context.dart';
import 'package:varanasi_mobile_app/widgets/input_field.dart';

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
    final theme = context.theme;
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

  static Future<T?> showOptionsPicker<T>(
    BuildContext? context,
    T initialValue,
    List<T> options,
    String Function(T) labelMapper, {
    String? title,
    String closeLabel = 'Close',
    String selectLabel = 'Save',
  }) async {
    context ??= appContext;
    Widget builder(context) {
      final viewInsets = MediaQuery.viewInsetsOf(context);
      var selectedValue = initialValue;
      return StatefulBuilder(builder: (context, setState) {
        return SizedBox(
          height: 300,
          child: Card(
            color: context.colorScheme.surface,
            child: Padding(
              padding: EdgeInsets.only(bottom: viewInsets.bottom),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Expanded(
                          flex: 4,
                          child: SizedBox.shrink(),
                        ),
                        if (title != null)
                          Expanded(
                            flex: 12,
                            child: Text(
                              title,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        Expanded(
                          flex: 4,
                          child: CupertinoButton(
                            child: Text(selectLabel),
                            onPressed: () => context.pop(selectedValue),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: CupertinoPicker.builder(
                        childCount: options.length,
                        itemBuilder: (_, i) {
                          return Center(child: Text(labelMapper(options[i])));
                        },
                        magnification: 1.2,
                        useMagnifier: true,
                        itemExtent: 36,
                        onSelectedItemChanged: (int value) {
                          setState(() => selectedValue = options[value]);
                        },
                        squeeze: 1.2,
                        scrollController: FixedExtentScrollController(
                          initialItem: options.indexOf(initialValue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
    }

    switch (context.theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return await showModalBottomSheet(
          context: context,
          builder: builder,
        );
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return await showCupertinoModalPopup<T>(
          context: context,
          builder: builder,
        );
    }
  }

  static Future<T?> showInputDialog<T>({
    BuildContext? context,
    required String title,
    required ValueChanged<String> onConfirm,
    String? placeholder,
    VoidCallback? onCancel,
    String cancelLabel = 'Cancel',
    String confirmLabel = 'Yes',
    AppDialogAction defaultAction = AppDialogAction.cancel,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    TextStyle? cancelLabelStyle,
    TextStyle? confirmLabelStyle,
    T Function()? onWillPop,
    String initialValue = '',
    TextEditingController? controller,
  }) {
    controller ??= TextEditingController(text: initialValue);

    Widget buildInputField(BuildContext context) {
      switch (context.theme.platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          return InputFormField.small(
            controller: controller,
            autofocus: true,
            style: context.textTheme.bodyMedium,
            decoration: filledInputDecorationMedium(context, noBorder: true),
          );
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          return CupertinoTextField(
            controller: controller,
            placeholder: placeholder,
            autofocus: true,
            style: context.textTheme.bodyMedium,
          );
      }
    }

    return showAdaptiveDialog<T>(
      context: context ?? appContext,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(title, style: titleStyle),
          titleTextStyle: titleStyle,
          content: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: buildInputField(context),
          ),
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
                onConfirm(controller?.text ?? initialValue);
              },
              child: Text(confirmLabel, style: confirmLabelStyle),
              textStyle: confirmLabelStyle,
            ),
          ],
        );
      },
    );
  }
}
