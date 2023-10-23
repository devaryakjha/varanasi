import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/models/sort_type.dart';
import 'package:varanasi_mobile_app/utils/dialogs/app_dialog.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

class SortByToggle extends StatelessWidget {
  const SortByToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final sortBy = context.select((ConfigCubit cubit) => cubit.sortType);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white38,
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
        final value = await AppDialog.showOptionsPicker(
          context,
          sortBy,
          SortBy.values,
          (e) => e.name.capitalize,
          title: "Sort by",
        );
        if (context.mounted && value != null) {
          context.read<ConfigCubit>().setSortType(value);
        }
      },
    );
  }
}
