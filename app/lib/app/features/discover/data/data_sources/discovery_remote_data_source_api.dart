import 'package:rxdart/subjects.dart';
import 'package:varanasi/app/features/discover/data/data_sources/discovery_remote_data_source.dart';
import 'package:varanasi/app/features/discover/data/models/discovery_data.dart';

final class DiscoveryRemoteDataSourceApi implements DiscoveryRemoteDataSource {
  DiscoveryRemoteDataSourceApi() {
    _blocksStreamController = BehaviorSubject<DiscoveryDataModel?>();
  }

  late final BehaviorSubject<DiscoveryDataModel?> _blocksStreamController;

  @override
  Stream<DiscoveryDataModel?> get blocksStream =>
      _blocksStreamController.stream.asBroadcastStream().distinct();

  @override
  Future<DiscoveryDataModel> getDiscoverBlocks() {
    // TODO(Arya): implement getDiscoverBlocks
    throw UnimplementedError();
  }
}
