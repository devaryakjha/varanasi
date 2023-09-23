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
  final CarouselController? miniPlayerPageController, playerPageController;
  final PanelController panelController;

  const ConfigLoaded({
    required this.config,
    this.miniPlayerPageController,
    this.playerPageController,
    required this.panelController,
  });

  @override
  List<Object?> get props => [
        config,
        miniPlayerPageController,
        panelController,
        playerPageController,
      ];

  ConfigLoaded copyWith({
    AppConfig? config,
    CarouselController? miniPlayerPageController,
    CarouselController? playerPageController,
    PanelController? panelController,
  }) {
    return ConfigLoaded(
      config: config ?? this.config,
      playerPageController: playerPageController ?? this.playerPageController,
      panelController: panelController ?? this.panelController,
      miniPlayerPageController:
          miniPlayerPageController ?? this.miniPlayerPageController,
    );
  }
}
