import 'dart:async';

import 'package:varanasi/app/features/media_detail/domain/entities/artist_detail.dart';
import 'package:varanasi/app/features/media_detail/domain/repositories/media_detail_repository.dart';

class ListenArtistsDetailsDataUseCase {
  ListenArtistsDetailsDataUseCase(this._repository);

  final MediaDetailRepository _repository;

  StreamSubscription<ArtistDetails>? _subscription;

  StreamSubscription<ArtistDetails> call(
    void Function(ArtistDetails)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _subscription = _repository.artistDetailsStream.listen(
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
