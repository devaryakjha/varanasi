part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchModules extends HomeEvent {
  final bool refetch;
  const FetchModules({this.refetch = false});
}
