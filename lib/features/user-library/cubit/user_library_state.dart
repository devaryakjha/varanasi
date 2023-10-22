// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_library_cubit.dart';

sealed class UserLibraryState extends Equatable {
  const UserLibraryState();

  @override
  List<Object> get props => [];
}

final class UserLibraryInitial extends UserLibraryState {}

class UserLibraryLoaded extends UserLibraryState {
  final List<UserLibrary> library;

  const UserLibraryLoaded({
    required this.library,
  });

  UserLibraryLoaded copyWith({
    List<UserLibrary>? library,
  }) {
    return UserLibraryLoaded(
      library: library ?? this.library,
    );
  }

  @override
  List<Object> get props => [library];

  Favorite get favorite => library.firstWhere(
        (library) => library is Favorite,
        orElse: () => const Favorite.empty(),
      ) as Favorite;
}
