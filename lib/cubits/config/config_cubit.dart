import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:varanasi_mobile_app/models/app_config.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/sort_type.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';
import 'package:varanasi_mobile_app/utils/constants/strings.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';

part 'config_state.dart';

class ConfigCubit extends AppCubit<ConfigState> {
  late final Box<AppConfig> _configBox;
  final Box _cacheBox = Hive.box(AppStrings.commonCacheBoxName);
  final Map<String, CachedNetworkImageProvider> _imageProviderCache = {};
  late final Expando<PaletteGenerator> _paletteGeneratorExpando;
  Logger logger = Logger.instance;

  ConfigCubit() : super(ConfigInitial());

  @override
  void init() async {
    _paletteGeneratorExpando = Expando<PaletteGenerator>();
    _configBox = await Hive.openBox<AppConfig>('config');
    if (_configBox.isEmpty) {
      logger.i('Config box is empty');
      _configBox.add(AppConfig());
    } else {
      logger.i('Config box is not empty');
    }
    emit(ConfigLoaded(
      config: _configBox.values.first,
      panelController: PanelController(),
      playerPageController: CarouselController(),
      miniPlayerPageController: CarouselController(),
    ));
  }

  Stream<SortBy> get sortTypeStream => stream.map(
      (state) => state is ConfigLoaded ? state.config.sortBy : SortBy.custom);

  SortBy get sortType => (state is ConfigLoaded)
      ? (state as ConfigLoaded).config.sortBy
      : SortBy.custom;

  void setSortType(SortBy sortBy) {
    if (state is ConfigLoaded) {
      final config = (state as ConfigLoaded).config.copyWith(sortBy: sortBy);
      _configBox.putAt(0, config);
      emit(ConfigLoaded(config: config, panelController: PanelController()));
    }
  }

  PaletteGenerator? maybeGetPaletteGenerator(String mediaUrl) {
    final provider = _imageProviderCache[mediaUrl];
    if (provider == null) return null;
    return _paletteGeneratorExpando[provider];
  }

  CachedNetworkImageProvider getProvider(String mediaUrl) {
    return _imageProviderCache[mediaUrl] ??=
        CachedNetworkImageProvider(mediaUrl);
  }

  Future<PaletteGenerator?> generatePalleteGenerator(String mediaUrl) async {
    try {
      final exists = maybeGetPaletteGenerator(mediaUrl);
      if (exists != null) return exists;
      final provider = getProvider(mediaUrl);
      final paletteGenerator =
          await PaletteGenerator.fromImageProvider(provider);
      _paletteGeneratorExpando[provider] = paletteGenerator;
      return paletteGenerator;
    } catch (e) {
      return null;
    }
  }

  CarouselController? get miniPlayerPageController => (state is ConfigLoaded)
      ? (state as ConfigLoaded).miniPlayerPageController
      : null;

  CarouselController? get playerPageController => (state is ConfigLoaded)
      ? (state as ConfigLoaded).playerPageController
      : null;

  Future<void> saveCurrentPlaylist(MediaPlaylist playlist) {
    return _cacheBox.put(AppStrings.currentPlaylistCacheKey, playlist);
  }

  Future<void> clearCurrentPlaylist() {
    return _cacheBox.delete(AppStrings.currentPlaylistCacheKey);
  }

  MediaPlaylist? get savedPlaylist {
    return _cacheBox.get(AppStrings.currentPlaylistCacheKey);
  }

  Future<void> saveCurrentPlaylistIndex(int index) {
    return _cacheBox.put(AppStrings.currentPlaylistIndexCacheKey, index);
  }

  Future<void> clearCurrentPlaylistIndex() {
    return _cacheBox.delete(AppStrings.currentPlaylistIndexCacheKey);
  }

  int? get savedPlaylistIndex {
    return _cacheBox.get(AppStrings.currentPlaylistIndexCacheKey);
  }

  Future<void> saveCurrentPosition(Duration duration) {
    return _cacheBox.put(
      AppStrings.currentPlaylistPositionKey,
      duration.inMilliseconds,
    );
  }

  Future<void> clearCurrentPosition() {
    return _cacheBox.delete(AppStrings.currentPlaylistPositionKey);
  }

  Duration? get savedPosition {
    final milliseconds = _cacheBox.get(AppStrings.currentPlaylistPositionKey);
    if (milliseconds == null) return null;
    return Duration(milliseconds: milliseconds);
  }
}
