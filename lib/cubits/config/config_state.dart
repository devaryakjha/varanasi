part of 'config_cubit.dart';

sealed class ConfigState extends Equatable {
  const ConfigState();

  @override
  List<Object> get props => [];
}

final class ConfigInitial extends ConfigState {}

final class ConfigLoaded extends ConfigState {
  final AppConfig config;

  const ConfigLoaded({required this.config});

  @override
  List<Object> get props => [config];
}
