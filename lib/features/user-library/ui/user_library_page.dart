import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/features/user-library/cubit/user_library_cubit.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';

class UserLibraryPage extends StatelessWidget {
  const UserLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Library'),
        centerTitle: false,
      ),
      body: BlocBuilder<UserLibraryCubit, UserLibraryState>(
        builder: (context, state) {
          if (state is! UserLibraryLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          final library = state.library;
          return ListView.builder(
            itemBuilder: (context, index) {
              final item = library[index];
              return ListTile(
                onTap: () => context.push(AppRoutes.library.path, extra: item),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: item.images.lastOrNull?.link ?? '',
                    height: 48,
                    width: 48,
                  ),
                ),
                title: Text(item.title ?? ''),
                subtitle: Text(item.description ?? ''),
              );
            },
            itemCount: library.length,
          );
        },
      ),
    );
  }
}
