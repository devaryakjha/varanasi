// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_library_cubit.dart';

sealed class UserLibraryState extends Equatable {
  const UserLibraryState();

  @override
  List<Object> get props => [];
}

final class UserLibraryInitial extends UserLibraryState {}

class UserLibraryLoaded extends UserLibraryState {
  final List<MediaPlaylist> library;

  const UserLibraryLoaded({
    required this.library,
  });

  UserLibraryLoaded copyWith({
    List<MediaPlaylist>? library,
  }) {
    return UserLibraryLoaded(
      library: library ?? this.library,
    );
  }

  @override
  List<Object> get props => [library];

  bool get isEmpty => library.isEmpty;

  bool isAdded(MediaPlaylist playlist) {
    return library.any((a) => playlist.id == a.id);
  }

  MediaPlaylist? get favorite {
    return library.firstWhereOrNull((e) => e.isFavorite);
  }
}
