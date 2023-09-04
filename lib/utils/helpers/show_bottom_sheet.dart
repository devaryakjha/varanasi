import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/utils/constants/colors.dart';

Future<T?> showAppBottomSheet<T>(
  BuildContext context, {
  required Widget Function(BuildContext) builder,
}) =>
    showModalBottomSheet<T>(
      context: context,
      builder: (context) => BottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        elevation: 10,
        backgroundColor: AppColors.bottomSheetBackground,
        onClosing: () {},
        builder: builder,
      ),
    );
