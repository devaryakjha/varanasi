import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:varanasi/app/features/discover/domain/use_cases/fetch_discover_data_use_case.dart';
import 'package:varanasi/app/shared/data/models/block.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit({
    required FetchDiscoverDataUseCase fetchDiscoverDataUseCase,
  })  : _fetchDiscoverDataUseCase = fetchDiscoverDataUseCase,
        super(const DiscoverState());

  final FetchDiscoverDataUseCase _fetchDiscoverDataUseCase;

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
}
