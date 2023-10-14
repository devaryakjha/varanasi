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
  final PackageInfo packageInfo;

  const ConfigLoaded({
    required this.config,
    this.miniPlayerPageController,
    this.playerPageController,
    required this.panelController,
    required this.packageInfo,
  });

  @override
  List<Object?> get props => [
        config,
        miniPlayerPageController,
        panelController,
        playerPageController,
        packageInfo,
      ];

  ConfigLoaded copyWith({
    AppConfig? config,
    CarouselController? miniPlayerPageController,
    CarouselController? playerPageController,
    PanelController? panelController,
    PackageInfo? packageInfo,
  }) {
    return ConfigLoaded(
      packageInfo: packageInfo ?? this.packageInfo,
      config: config ?? this.config,
      playerPageController: playerPageController ?? this.playerPageController,
      panelController: panelController ?? this.panelController,
      miniPlayerPageController:
          miniPlayerPageController ?? this.miniPlayerPageController,
    );
  }
}
