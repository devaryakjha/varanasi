// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final ModulesResponse? modules;

  const HomeState({
    this.modules,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [modules, isLoading];

  HomeState copyWith({
    bool? isLoading,
    ModulesResponse? modules,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      modules: modules ?? this.modules,
    );
  }
}
