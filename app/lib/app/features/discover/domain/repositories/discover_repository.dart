import 'package:varanasi/app/features/discover/domain/entities/discovery_data.dart';

abstract class DiscoverRepository {
  Stream<DiscoveryData> get blocksStream;
  Future<DiscoveryData> getDiscoverBlocks();
}
