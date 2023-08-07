import 'package:hive/hive.dart';
import 'package:varanasi_mobile_app/models/download_url.dart';

import 'album.dart';
import 'artist.dart';
import 'image.dart';
import 'playlist.dart';
import 'primary_artist.dart';
import 'song.dart';

void registerCommonTypeAdapters() {
  Hive.registerAdapter<Album>(AlbumAdapter());
  Hive.registerAdapter<Artist>(ArtistAdapter());
  Hive.registerAdapter<Image>(ImageAdapter());
  Hive.registerAdapter<Playlist>(PlaylistAdapter());
  Hive.registerAdapter<PrimaryArtist>(PrimaryArtistAdapter());
  Hive.registerAdapter<Song>(SongAdapter());
  Hive.registerAdapter<DownloadUrl>(DownloadUrlAdapter());
}
