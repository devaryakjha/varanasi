import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/utils/extensions/router.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';

class FindInPlaylist extends StatelessWidget {
  const FindInPlaylist({super.key, required this.state});

  final MediaLoadedState state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final existingPath = context.routerState.path;
        context.push(
          '$existingPath/${AppRoutes.librarySearch.path}',
          extra:
              state.sortedMediaPlaylist(context.read<ConfigCubit>().sortType),
        );
      },
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.circular(2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: const Row(
          children: [
            FittedBox(child: Icon(Icons.search, size: 20)),
            SizedBox(width: 4),
            Text(
              'Find in playlist',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
