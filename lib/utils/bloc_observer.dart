import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';

class AppBlocObserver extends BlocObserver {
  Logger get _logger => Logger.instance;

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _logger.i('onCreate -- ${bloc.runtimeType}');
  }
}
