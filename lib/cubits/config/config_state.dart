// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'config_cubit.dart';

sealed class ConfigState extends Equatable {
  const ConfigState();

  @override
  List<Object?> get props => [];
}

final class ConfigInitial extends ConfigState {}

final class ConfigLoaded extends ConfigState {
  final AppConfig config;
  final CarouselController? miniPlayerPageController;

  const ConfigLoaded({
    required this.config,
    this.miniPlayerPageController,
  });

  @override
  List<Object?> get props => [config, miniPlayerPageController];

  ConfigLoaded copyWith({
    AppConfig? config,
    CarouselController? miniPlayerPageController,
  }) {
    return ConfigLoaded(
      config: config ?? this.config,
      miniPlayerPageController:
          miniPlayerPageController ?? this.miniPlayerPageController,
    );
  }
}
