import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:varanasi_mobile_app/models/app_config.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/sort_type.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';
import 'package:varanasi_mobile_app/utils/constants/strings.dart';
import 'package:varanasi_mobile_app/utils/helpers/get_app_context.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';

part 'config_state.dart';

class ConfigCubit extends AppCubit<ConfigState> {
  final Map<String, CachedNetworkImageProvider> _imageProviderCache = {};
  late final Expando<PaletteGenerator> _paletteGeneratorExpando;
  Logger logger = Logger.instance;

  Box<AppConfig> get _configBox => AppConfig.getBox;
  Box get _cacheBox => Hive.box(AppStrings.commonCacheBoxName);

  ConfigCubit() : super(ConfigInitial());

  static ConfigCubit read() => appContext.read<ConfigCubit>();

  Box get cacheBox => _cacheBox;

  @override
  void init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    _paletteGeneratorExpando = Expando<PaletteGenerator>();
    if (_configBox.isEmpty) {
      logger.i('Config box is empty');
      _configBox.add(AppConfig());
    } else {
      logger.i('Config box is not empty');
    }
    _configBox.watch().listen((event) {
      final config = event.value;
      if (config is! AppConfig) return;
      logger.i('Config box is changed with $config');
      if (state is ConfigLoaded) {
        emit((state as ConfigLoaded).copyWith(config: config));
      } else {
        emit(ConfigLoaded(
          config: config,
          panelController: PanelController(),
          playerPageController: CarouselController(),
          miniPlayerPageController: CarouselController(),
          packageInfo: packageInfo,
        ));
      }
    });
    emit(ConfigLoaded(
      config: _configBox.values.single,
      panelController: PanelController(),
      playerPageController: CarouselController(),
      miniPlayerPageController: CarouselController(),
      packageInfo: packageInfo,
      currentQueueIndex: savedPlaylistIndex,
      currentPlaylist: savedPlaylist,
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
    emit(configLoadedState.copyWith(currentPlaylist: playlist));
    return _cacheBox.put(AppStrings.currentPlaylistCacheKey, playlist);
  }

  Future<void> clearCurrentPlaylist() {
    emit(configLoadedState.copyWith(currentPlaylist: null));
    return _cacheBox.delete(AppStrings.currentPlaylistCacheKey);
  }

  MediaPlaylist? get savedPlaylist {
    return _cacheBox.get(AppStrings.currentPlaylistCacheKey);
  }

  Future<void> saveCurrentPlaylistIndex(int index) {
    emit(configLoadedState.copyWith(currentQueueIndex: index));
    return _cacheBox.put(AppStrings.currentPlaylistIndexCacheKey, index);
  }

  Future<void> clearCurrentPlaylistIndex() {
    emit(configLoadedState.copyWith(currentQueueIndex: null));
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

  Future<void> saveRepeatMode(int mode) async {
    if (this.state is! ConfigLoaded) return;
    final state = this.state as ConfigLoaded;
    final config = state.config.copyWith(repeatMode: mode);
    await _configBox.putAt(0, config);
  }

  AudioServiceRepeatMode get repeatMode {
    if (_configBox.isEmpty) return AudioServiceRepeatMode.none;
    return AudioServiceRepeatMode.values[_configBox.values.first.repeatMode];
  }

  ConfigLoaded get configLoadedState => state is ConfigLoaded
      ? state as ConfigLoaded
      : throw Exception('Config is not loaded');

  ConfigLoaded? get configOrNull =>
      state is ConfigLoaded ? state as ConfigLoaded : null;

  PlayableMedia? get currentMedia =>
      savedPlaylist?.mediaItems?[savedPlaylistIndex ?? 0];
}
