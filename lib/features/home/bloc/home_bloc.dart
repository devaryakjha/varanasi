import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/home/data/home_repository.dart';
import 'package:varanasi_mobile_app/features/home/data/models/home_page_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(const HomeInitialState());

  FutureOr<void> fetchModule({bool refetch = true}) async {
    try {
      emit(const HomeLoadingState());
      final modules =
          await HomeRepository.instance.fetchModules(ignoreCache: refetch);
      emit(HomeLoadedState(modules));
    } catch (e) {
      emit(HomeErrorState(e));
    }
  }
}
