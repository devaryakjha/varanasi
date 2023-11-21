import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:varanasi_mobile_app/features/home/data/home_repository.dart';
import 'package:varanasi_mobile_app/features/home/data/models/home_page_data.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';
import 'package:varanasi_mobile_app/utils/exceptions/app_exception.dart';
import 'package:varanasi_mobile_app/utils/services/new_releases_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeCubit extends AppCubit<HomeState> {
  HomeCubit() : super(const HomeInitialState());

  FutureOr<void> fetchModule({bool refetch = false}) async {
    try {
      emit(const HomeLoadingState());
      final modules =
          await HomeRepository.instance.fetchModules(ignoreCache: refetch);
      emit(HomeLoadedState(modules));
    } on AppException catch (e) {
      emit(HomeErrorState(e));
    }
  }

  @override
  FutureOr<void> init() async {
    await fetchModule();
    NewReleasesService.instance.fetchNewReleases();
  }
}
