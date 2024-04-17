import 'package:varanasi/app/features/discover/data/models/discovery_data.dart';

abstract class DiscoveryRemoteDataSource {
  Stream<DiscoveryDataModel?> get blocksStream;
  Future<DiscoveryDataModel> getDiscoverBlocks();
}
