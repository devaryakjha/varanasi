import 'package:varanasi/app/features/media_detail/domain/entities/artist_detail.dart';

abstract class MediaDetailRepository {
  Stream<ArtistDetails> get artistDetailsStream;
  Future<ArtistDetails> getArtistDetailsFromToken(String token);
}
