import 'package:varanasi/app/features/media_detail/domain/entities/artist_detail.dart';
import 'package:varanasi/app/features/media_detail/domain/repositories/media_detail_repository.dart';

class FetchArtistDetailsUseCase {
  FetchArtistDetailsUseCase(this._repository);
  final MediaDetailRepository _repository;

  Future<ArtistDetails> call(String token) =>
      _repository.getArtistDetailsFromToken(token);
}
