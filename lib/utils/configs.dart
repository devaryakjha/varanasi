import 'package:equatable/equatable.dart';

class Search {
  final String all;
  final String songs;
  final String albums;
  final String playlists;
  final String artists;

  const Search({
    required this.all,
    required this.songs,
    required this.albums,
    required this.playlists,
    required this.artists,
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
  final String id;
  final String link;

  const Albums({
    required this.id,
    required this.link,
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
  final Search? search;
  final Songs? songs;
  final Albums? albums;
  final Playlists? playlists;
  final Artists? artists;
  final String? lyrics;

  const Endpoint({
    required this.modules,
    this.search,
    this.songs,
    this.albums,
    this.playlists,
    this.artists,
    this.lyrics,
  });
}

class Server extends Equatable {
  final String host;
  final int? port;

  const Server(this.host, this.port);

  String get baseUrl => port == null ? host : '$host:$port';

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
  const server = Server('http://192.168.31.130', 3000);
  return Config(
    env: 'development',
    endpoint: const Endpoint(
      modules: '/modules',
      playlists: Playlists(id: 'playlists'),
    ),
    server: server,
    placeholderImageLink: '${server.baseUrl}/audio.jpg',
  );
}
