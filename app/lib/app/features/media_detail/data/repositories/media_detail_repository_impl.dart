import 'package:varanasi/app/features/media_detail/data/data_source/media_detail_data_source.dart';
import 'package:varanasi/app/features/media_detail/domain/entities/artist_detail.dart';
import 'package:varanasi/app/features/media_detail/domain/repositories/media_detail_repository.dart';

class MediaDetailRepositoryImpl implements MediaDetailRepository {
  MediaDetailRepositoryImpl({required this.dataSource});

  final MediaDetailRemoteDataSource dataSource;

  @override
  Stream<ArtistDetails> get artistDetailsStream {
    return dataSource.artistDetailsStream.map((model) {
      if (model == null) {
        return const ArtistDetails.empty();
      }
      return model.toEntity();
    });
  }

  @override
  Future<ArtistDetails> getArtistDetailsFromToken(String token) {
    return dataSource.getArtistDetailsFromToken(token).then((model) {
      return model.toEntity();
    });
  }
}
