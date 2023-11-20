import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/user-library/cubit/user_library_cubit.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';

class AddToPlaylistPage extends StatefulWidget {
  const AddToPlaylistPage({super.key});

  @override
  State<AddToPlaylistPage> createState() => _AddToPlaylistPageState();
}

class _AddToPlaylistPageState extends State<AddToPlaylistPage> {
  List<MediaPlaylist> _playlists = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<UserLibraryCubit>()
          .generateAddToPlaylistSuggestions()
          .then((value) {
        _playlists = value;
      });
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    Logger.instance.d("AddToPlaylistPage disposed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Add to playlist ${_playlists.length}"),
      ),
    );
  }
}
