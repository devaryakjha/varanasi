import 'package:hive/hive.dart';
import 'package:varanasi_mobile_app/models/download.dart';
import 'package:varanasi_mobile_app/models/sort_type.dart';

import 'album.dart';
import 'app_config.dart';
import 'artist.dart';
import 'download_url.dart';
import 'image.dart';
import 'media_playlist.dart';
import 'playable_item_impl.dart';
import 'playlist.dart';
import 'primary_artist.dart';
import 'song.dart';

void registerCommonTypeAdapters() {
  Hive.registerAdapter<PlayableMediaImpl>(PlayableMediaImplAdapter());
  Hive.registerAdapter<DownloadQuality>(DownloadQualityAdapter());
  Hive.registerAdapter<SortBy>(SortByAdapter());
  Hive.registerAdapter<AppConfig>(AppConfigAdapter());
  Hive.registerAdapter<Album>(AlbumAdapter());
  Hive.registerAdapter<Artist>(ArtistAdapter());
  Hive.registerAdapter<Image>(ImageAdapter());
  Hive.registerAdapter<Playlist>(PlaylistAdapter());
  Hive.registerAdapter<PrimaryArtist>(PrimaryArtistAdapter());
  Hive.registerAdapter<Song>(SongAdapter());
  Hive.registerAdapter<DownloadedMedia>(DownloadedMediaAdapter());
  Hive.registerAdapter<DownloadUrl>(DownloadUrlAdapter());
  Hive.registerAdapter<MediaPlaylist>(MediaPlaylistAdapter());
}
