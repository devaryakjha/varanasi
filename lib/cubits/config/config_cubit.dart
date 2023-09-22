import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:varanasi_mobile_app/models/app_config.dart';
import 'package:varanasi_mobile_app/models/sort_type.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';

part 'config_state.dart';

class ConfigCubit extends Cubit<ConfigState> {
  late final Box<AppConfig> _configBox;
  final Map<String, CachedNetworkImageProvider> _imageProviderCache = {};
  late final Expando<PaletteGenerator> _paletteGeneratorExpando;
  Logger logger = Logger.instance;

  ConfigCubit() : super(ConfigInitial());

  void initialise() async {
    _paletteGeneratorExpando = Expando<PaletteGenerator>();
    _configBox = await Hive.openBox<AppConfig>('config');
    if (_configBox.isEmpty) {
      logger.i('Config box is empty');
      _configBox.add(AppConfig());
    } else {
      logger.i('Config box is not empty');
    }
    emit(ConfigLoaded(config: _configBox.values.first));
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
      emit(ConfigLoaded(config: config));
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
}
