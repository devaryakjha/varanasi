import 'package:hive_flutter/adapters.dart';

import 'album.dart';
import 'artist.dart';
import 'chart.dart';
import 'home_page_data.dart';
import 'image.dart';
import 'playlist.dart';
import 'primary_artist.dart';
import 'songs.dart';
import 'trending.dart';

void registerHomePageTypeAdapters() {
  Hive.registerAdapter<Album>(AlbumAdapter());
  Hive.registerAdapter<Artist>(ArtistAdapter());
  Hive.registerAdapter<Chart>(ChartAdapter());
  Hive.registerAdapter<HomePageData>(HomePageDataAdapter());
  Hive.registerAdapter<Image>(ImageAdapter());
  Hive.registerAdapter<Playlist>(PlaylistAdapter());
  Hive.registerAdapter<PrimaryArtist>(PrimaryArtistAdapter());
  Hive.registerAdapter<Song>(SongAdapter());
  Hive.registerAdapter<Trending>(TrendingAdapter());
}
