import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/user-library/cubit/user_library_cubit.dart';

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
          final library =
              state.library.map((e) => e.toMediaPlaylist()).toList();
          return ListView.builder(
            itemBuilder: (context, index) {
              final item = library[index];
              return ListTile(
                leading: Text(item.title ?? ''),
              );
            },
            itemCount: library.length,
          );
        },
      ),
    );
  }
}
