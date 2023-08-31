import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:varanasi_mobile_app/models/app_config.dart';
import 'package:varanasi_mobile_app/models/sort_type.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';

part 'config_state.dart';

class ConfigCubit extends Cubit<ConfigState> {
  late final Box<AppConfig> _configBox;
  Logger logger = Logger.instance;

  ConfigCubit() : super(ConfigInitial());

  void initialise() async {
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
}
