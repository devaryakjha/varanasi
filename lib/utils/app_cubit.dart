import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppCubit<State> extends Cubit<State> {
  AppCubit(super.initialState);

  FutureOr<void> init();
}
