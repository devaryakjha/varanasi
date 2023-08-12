import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/sort_type.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/helpers/shoe_bottom_sheet.dart';

class SortByToggle extends StatelessWidget {
  const SortByToggle({
    super.key,
    required this.state,
  });

  final LibraryLoaded<PlayableMedia> state;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Sort',
      icon: const Icon(Icons.sort),
      onPressed: () async {
        // show dialog
        final value = await showAppBottomSheet<SortBy>(
          context,
          builder: (context) => ListView(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: MediaQuery.paddingOf(context).bottom,
              top: 16,
            ),
            children: [
              ListTile(
                title: const Text('Sort by'),
                titleTextStyle: context.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              RadioListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                groupValue: state.sortBy,
                value: SortBy.custom,
                onChanged: (value) => context.pop(value),
                title: const Text('Custom'),
                selected: state.sortBy == SortBy.custom,
              ),
              RadioListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                groupValue: state.sortBy,
                value: SortBy.title,
                onChanged: (value) => context.pop(value),
                title: const Text('Title'),
              ),
            ],
          ),
        );
        if (context.mounted && value != null) {
          context.read<LibraryCubit>().sortBy(value);
        }
      },
    );
  }
}
