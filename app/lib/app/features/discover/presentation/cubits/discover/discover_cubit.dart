import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:varanasi/app/features/discover/domain/entities/discovery_data.dart';
import 'package:varanasi/app/features/discover/domain/use_cases/fetch_discover_data_use_case.dart';
import 'package:varanasi/app/features/discover/domain/use_cases/listen_discover_data_use_case.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit({
    required FetchDiscoverDataUseCase fetchDiscoverDataUseCase,
    required ListenDiscoverDataUseCase listenDiscoverDataUseCase,
  })  : _fetchDiscoverDataUseCase = fetchDiscoverDataUseCase,
        _listenDiscoverDataUseCase = listenDiscoverDataUseCase,
        super(const DiscoverState()) {
    listenToDiscoverData();
  }

  final FetchDiscoverDataUseCase _fetchDiscoverDataUseCase;
  final ListenDiscoverDataUseCase _listenDiscoverDataUseCase;

  Future<void> fetchDiscoverData() async {
    if (state.isLoading) return;

    try {
      emit(state.copyWith(isLoading: true));
      await _fetchDiscoverDataUseCase();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void listenToDiscoverData() {
    _listenDiscoverDataUseCase(
      (discoveryData) {
        emit(state.copyWith(discoveryData: discoveryData));
      },
    );
  }

  @override
  Future<void> close() {
    _listenDiscoverDataUseCase.close();
    return super.close();
  }
}
