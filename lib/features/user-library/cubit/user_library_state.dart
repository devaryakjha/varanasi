part of 'user_library_cubit.dart';

sealed class UserLibraryState extends Equatable {
  const UserLibraryState();

  @override
  List<Object> get props => [];
}

final class UserLibraryInitial extends UserLibraryState {}
