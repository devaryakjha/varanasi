import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Search {
  final String all;
  final String songs;
  final String albums;
  final String playlists;
  final String artists;
  final String topSearches;

  const Search({
    required this.all,
    required this.songs,
    required this.albums,
    required this.playlists,
    required this.artists,
    required this.topSearches,
  });
}

class Songs {
  final String id;
  final String link;

  const Songs({
    required this.id,
    required this.link,
  });
}

class Albums {
  final String link;
  final String id;

  const Albums({
    required this.link,
    required this.id,
  });
}

class Playlists {
  final String id;

  const Playlists({
    required this.id,
  });
}

class Artists {
  final String id;
  final String link;
  final String songs;
  final String topSongs;
  final String albums;

  const Artists({
    required this.id,
    required this.link,
    required this.songs,
    required this.topSongs,
    required this.albums,
  });
}

class Endpoint {
  final String modules;
  final Search search;
  final Songs? songs;
  final Albums? albums;
  final Playlists? playlists;
  final Artists? artists;
  final String? lyrics;
  final String newReleases;

  const Endpoint({
    required this.modules,
    required this.search,
    this.songs,
    this.albums,
    this.playlists,
    this.artists,
    this.lyrics,
    required this.newReleases,
  });
}

class Server extends Equatable {
  final String host;
  final int? port;

  const Server(this.host, [this.port]);

  String get baseUrl => "${port == null ? host : '$host:$port'}/";

  @override
  List<Object?> get props => [host, port];
}

class Config extends Equatable {
  final String env;
  final Server server;
  final Endpoint endpoint;
  final String placeholderImageLink;

  const Config({
    required this.server,
    required this.env,
    required this.endpoint,
    required this.placeholderImageLink,
  });

  @override
  List<Object> get props => [env, endpoint, server, placeholderImageLink];
}

Config get appConfig {
  const server = kReleaseMode
      ? Server('https://aryak.dev/api/varanasi')
      : Server('https://varanasi-backend-297lplmib-devaryakjha.vercel.app');
  return Config(
    env: kReleaseMode ? 'production' : 'development',
    endpoint: const Endpoint(
      modules: '/modules',
      playlists: Playlists(id: 'playlists'),
      albums: Albums(id: 'albums', link: 'albums'),
      songs: Songs(id: 'songs', link: 'songs'),
      search: Search(
        all: "/search/all",
        songs: '/search/songs',
        albums: '/search/albums',
        playlists: '/search/playlists',
        artists: '/search/artists',
        topSearches: '/search/top-searches',
      ),
      newReleases: 'new-releases',
    ),
    server: server,
    placeholderImageLink: '${server.baseUrl}audio.jpg',
  );
}
