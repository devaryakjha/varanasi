import 'package:varanasi/app/features/discover/domain/entities/discovery_data.dart';
import 'package:varanasi/app/features/discover/domain/repositories/discover_repository.dart';

class FetchDiscoverDataUseCase {
  FetchDiscoverDataUseCase(this._repository);

  final DiscoverRepository _repository;

  Future<DiscoveryData> call() => _repository.getDiscoverBlocks();
}
