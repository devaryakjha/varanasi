import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/home/data/home_repository.dart';
import 'package:varanasi_mobile_app/features/home/data/models/home_page_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<FetchModules>(_fetchModule);
  }

  FutureOr<void> _fetchModule(
    FetchModules event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final modules =
        await HomeRepository.instance.fetchModules(ignoreCache: event.refetch);
    emit(state.copyWith(modules: modules, isLoading: false));
  }
}
