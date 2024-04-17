import 'dart:async';

import 'package:varanasi/app/features/discover/domain/entities/discovery_data.dart';
import 'package:varanasi/app/features/discover/domain/repositories/discover_repository.dart';

class ListenDiscoverDataUseCase {
  ListenDiscoverDataUseCase(this._repository);

  final DiscoverRepository _repository;

  StreamSubscription<DiscoveryData>? _subscription;

  StreamSubscription<DiscoveryData> call(
    void Function(DiscoveryData)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _subscription = _repository.blocksStream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  void close() {
    _subscription?.cancel();
  }
}
