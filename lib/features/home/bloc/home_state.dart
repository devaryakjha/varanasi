part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

class HomeInitialState extends HomeState {
  const HomeInitialState();

  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();

  @override
  List<Object?> get props => [];
}

class HomeLoadedState extends HomeState {
  final HomePageData? modules;

  const HomeLoadedState(this.modules);

  @override
  List<Object?> get props => [modules];
}

class HomeErrorState extends HomeState {
  final AppException error;

  const HomeErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
