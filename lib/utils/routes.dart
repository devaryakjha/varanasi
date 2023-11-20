typedef Route = ({String name, String path});

class AppRoutes {
  /// Application wide routes
  static const Route library = (name: 'media-library', path: '/media-library');
  static const Route librarySearch = (name: 'library-search', path: 'search');
  static const Route authentication = (name: 'auth', path: '/auth');
  static const Route login = (name: 'login', path: 'login');
  static const Route signup = (name: 'signup', path: 'signup');
  static const Route splash = (name: 'splash', path: '/splash');

  // home specific routes
  static const Route home = (name: 'home', path: '/home');

  // search specific routes
  static const Route search = (name: 'search', path: '/search');

  // user specific routes
  static const Route userlibrary = (name: 'library', path: '/library');
  static const Route createLibrary =
      (name: 'create-library', path: '/create-library');

  // settings specific routes
  static const Route settings = (name: 'settings', path: '/settings');
}
