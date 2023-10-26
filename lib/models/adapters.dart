import 'package:hive/hive.dart';
import 'package:varanasi_mobile_app/features/user-library/data/user_library.dart';
import 'package:varanasi_mobile_app/models/download.dart';
import 'package:varanasi_mobile_app/models/recent_media.dart';
import 'package:varanasi_mobile_app/models/sort_type.dart';

import 'album.dart';
import 'app_config.dart';
import 'artist.dart';
import 'download_url.dart';
import 'image.dart';
import 'media_playlist.dart';
import 'playlist.dart';
import 'primary_artist.dart';
import 'song.dart';

void registerCommonTypeAdapters() {
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
  Hive.registerAdapter<UserLibraryType>(UserLibraryTypeAdapter());
  Hive.registerAdapter<UserLibrary>(UserLibraryAdapter());
  Hive.registerAdapter<Favorite>(FavoriteAdapter());
  Hive.registerAdapter<AlbumLibrary>(AlbumLibraryAdapter());
  Hive.registerAdapter<PlaylistLibrary>(PlaylistLibraryAdapter());
  Hive.registerAdapter<RecentMedia>(RecentMediaAdapter());
}
