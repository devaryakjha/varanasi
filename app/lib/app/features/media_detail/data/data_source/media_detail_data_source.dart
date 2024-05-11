import 'package:varanasi/app/features/media_detail/data/models/artist_detail.dart';

abstract class MediaDetailRemoteDataSource {
  Stream<ArtistDetailsModel?> get artistDetailsStream;
  Future<ArtistDetailsModel> getArtistDetailsFromToken(String token);
}
