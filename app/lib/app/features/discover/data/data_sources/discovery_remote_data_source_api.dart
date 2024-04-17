import 'package:rxdart/subjects.dart';
import 'package:varanasi/app/features/discover/data/data_sources/discovery_remote_data_source.dart';
import 'package:varanasi/app/features/discover/data/models/discovery_data.dart';
import 'package:varanasi/core/api_client.dart';

final class DiscoveryRemoteDataSourceApi implements DiscoveryRemoteDataSource {
  DiscoveryRemoteDataSourceApi() {
    _blocksStreamController = BehaviorSubject<DiscoveryDataModel?>();
  }

  late final BehaviorSubject<DiscoveryDataModel?> _blocksStreamController;

  @override
  Stream<DiscoveryDataModel?> get blocksStream =>
      _blocksStreamController.stream.asBroadcastStream().distinct();

  @override
  Future<DiscoveryDataModel> getDiscoverBlocks() async {
    try {
      final result = await ApiClient.get<DiscoveryDataModel>(
        '/discover',
        transformResponse: DiscoveryDataModel.fromJson,
      );

      if (result == null) {
        throw Exception('Failed to fetch discover blocks');
      }
      _blocksStreamController.sink.add(result);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
