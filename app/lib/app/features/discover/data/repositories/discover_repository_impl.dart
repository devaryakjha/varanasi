import 'package:varanasi/app/features/discover/data/data_sources/discovery_remote_data_source.dart';
import 'package:varanasi/app/features/discover/domain/entities/discovery_data.dart';
import 'package:varanasi/app/features/discover/domain/repositories/discover_repository.dart';

class DiscoverRepositoryImpl implements DiscoverRepository {
  DiscoverRepositoryImpl({required this.remoteDataSource});

  final DiscoveryRemoteDataSource remoteDataSource;

  @override
  Stream<DiscoveryData> get blocksStream {
    return remoteDataSource.blocksStream.map((event) {
      if (event == null) {
        return const DiscoveryData.empty();
      } else {
        return event.toEntity();
      }
    });
  }

  @override
  Future<DiscoveryData> getDiscoverBlocks() async {
    final blocks = await remoteDataSource.getDiscoverBlocks();
    return blocks.toEntity();
  }
}
