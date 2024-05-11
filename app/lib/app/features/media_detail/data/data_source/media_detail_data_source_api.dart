import 'package:rxdart/rxdart.dart';
import 'package:varanasi/app/features/media_detail/data/data_source/media_detail_data_source.dart';
import 'package:varanasi/app/features/media_detail/data/models/artist_detail.dart';
import 'package:varanasi/core/api_client.dart';

class MediaDetailDataRemoteSourceApi implements MediaDetailRemoteDataSource {
  MediaDetailDataRemoteSourceApi._() {
    _artistDetailsStreamController = BehaviorSubject<ArtistDetailsModel?>();
  }

  factory MediaDetailDataRemoteSourceApi.forId(String id) {
    return _cachedInstances.putIfAbsent(
      id,
      MediaDetailDataRemoteSourceApi._,
    );
  }

  // ignore: prefer_final_fields
  static Map<String, MediaDetailDataRemoteSourceApi> _cachedInstances = {};

  late final BehaviorSubject<ArtistDetailsModel?>
      _artistDetailsStreamController;

  @override
  Stream<ArtistDetailsModel?> get artistDetailsStream =>
      _artistDetailsStreamController.stream.asBroadcastStream().distinct();

  @override
  Future<ArtistDetailsModel> getArtistDetailsFromToken(String token) async {
    try {
      final result = await ApiClient.get<ArtistDetailsModel>(
        '/media-details/artists/$token',
        transformResponse: ArtistDetailsModel.fromJson,
      );

      if (result == null) {
        throw Exception('Failed to fetch artist details');
      }
      _artistDetailsStreamController.sink.add(result);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
