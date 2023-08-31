import 'package:varanasi_mobile_app/features/home/bloc/home_bloc.dart';
import 'package:varanasi_mobile_app/features/home/data/models/home_page_data.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';

typedef HomeStateData = (bool, HomePageData?, List<MediaPlaylist>, bool);

HomeStateData selectHomeStateData(HomeBloc value) {
  final state = value.state;
  final HomeStateData Function() data = switch (state.runtimeType) {
    HomeLoadedState => () {
        final modules = (state as HomeLoadedState).modules;
        final mediaPlaylist = [
          if (modules?.charts != null)
            MediaPlaylist(
              title: 'Popular Today',
              mediaItems: modules!.charts!,
            ),
          if (modules?.albums != null)
            MediaPlaylist(
              title: 'Albums',
              mediaItems: modules!.albums!,
            ),
          if (modules?.playlists != null)
            MediaPlaylist(
              title: 'Playlists',
              mediaItems: modules!.playlists!,
            ),
        ];
        return (false, modules, mediaPlaylist, false);
      },
    HomeErrorState => () => (false, null, [], true),
    _ => () => (false, null, [], false),
  };
  return data();
}
