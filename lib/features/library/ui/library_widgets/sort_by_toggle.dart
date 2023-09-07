import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/models/sort_type.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/helpers/show_bottom_sheet.dart';

class SortByToggle extends StatelessWidget {
  const SortByToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final sortBy = context.select((ConfigCubit cubit) => cubit.sortType);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white24,
        elevation: 0,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        minimumSize: const Size(0, 32),
        maximumSize: const Size(double.infinity, 32),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: const Text('Sort'),
      onPressed: () async {
        final padding = MediaQuery.paddingOf(context);
        // show dialog
        final value = await showAppBottomSheet<SortBy>(
          context,
          builder: (context) => ListView(
            padding: padding.copyWith(left: 8, right: 8, top: 16),
            children: [
              ListTile(
                title: const Text('Sort by'),
                titleTextStyle: context.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              ...SortBy.values.map(
                (e) => RadioListTile(
                  controlAffinity: ListTileControlAffinity.trailing,
                  groupValue: sortBy,
                  value: e,
                  onChanged: (value) => context.pop(value),
                  title: Text(describeEnum(e).capitalize),
                  selected: sortBy == e,
                ),
              ),
            ],
          ),
        );
        if (context.mounted && value != null) {
          context.read<ConfigCubit>().setSortType(value);
        }
      },
    );
  }
}
