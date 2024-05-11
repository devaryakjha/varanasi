import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:varanasi/app/features/media_detail/domain/entities/artist_detail.dart';
import 'package:varanasi/app/features/media_detail/domain/use_cases/fetch_artist_details_use_case.dart';
import 'package:varanasi/app/features/media_detail/domain/use_cases/listen_artist_details_use_case.dart';

part 'artist_detail_state.dart';

class ArtistDetailCubit extends Cubit<ArtistDetails> {
  ArtistDetailCubit({
    required FetchArtistDetailsUseCase fetchArtistDetailsUseCase,
    required ListenArtistsDetailsDataUseCase listenArtistsDetailsDataUseCase,
  })  : _fetchArtistDetailsUseCase = fetchArtistDetailsUseCase,
        _listenArtistsDetailsDataUseCase = listenArtistsDetailsDataUseCase,
        super(const ArtistDetails.empty()) {
    _listenToArtistDetails();
  }

  final FetchArtistDetailsUseCase _fetchArtistDetailsUseCase;
  final ListenArtistsDetailsDataUseCase _listenArtistsDetailsDataUseCase;

  Future<void> fetchArtistDetails(String token) async {
    try {
      await _fetchArtistDetailsUseCase(token);
      logInfo('Artist details fetched successfully.');
    } catch (e) {
      logError('Failed to fetch artist details: $e', error: e);
      emit(const ArtistDetails.empty());
    }
  }

  void _listenToArtistDetails() {
    _listenArtistsDetailsDataUseCase(emit);
  }

  @override
  void onChange(Change<ArtistDetails> change) {
    super.onChange(change);
  }

  @override
  Future<void> close() {
    _listenArtistsDetailsDataUseCase.close();
    return super.close();
  }
}
