import 'package:varanasi_mobile_app/features/home/bloc/home_bloc.dart';
import 'package:varanasi_mobile_app/features/home/data/models/home_page_data.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';

typedef HomeStateData = (
  HomePageData?,
  List<MediaPlaylist>,
  HomeState,
);

HomeStateData homePageDataSelector(HomeBloc value) {
  final state = value.state;
  final List<MediaPlaylist> medialist = [];
  return switch (state) {
    (HomeLoadedState state) => (state.modules, extractMediaList(state), state),
    (HomeErrorState state) => (null, medialist, state),
    _ => (null, medialist, state),
  };
}

List<MediaPlaylist<PlayableMedia>> extractMediaList(HomeLoadedState state) {
  final modules = state.modules;
  if (modules == null) return [];
  return [
    if (modules.charts != null) MediaPlaylist.popularToday(modules.charts!),
    if (modules.albums != null) MediaPlaylist.albums(modules.albums!),
    if (modules.playlists != null) MediaPlaylist.playlists(modules.playlists!),
  ];
}
