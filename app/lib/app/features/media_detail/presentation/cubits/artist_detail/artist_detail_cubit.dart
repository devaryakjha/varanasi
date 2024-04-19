import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
      final artistDetails = await _fetchArtistDetailsUseCase(token);
      emit(artistDetails);
    } catch (e) {
      emit(const ArtistDetails.empty());
    }
  }

  void _listenToArtistDetails() {
    _listenArtistsDetailsDataUseCase(emit);
  }

  @override
  Future<void> close() {
    _listenArtistsDetailsDataUseCase.close();
    return super.close();
  }
}
