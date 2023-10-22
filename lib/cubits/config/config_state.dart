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
  final CarouselController? playerPageController;
  final PanelController panelController;
  final PackageInfo packageInfo;
  final MediaPlaylist? currentPlaylist;
  final int? currentQueueIndex;

  const ConfigLoaded({
    required this.config,
    this.miniPlayerPageController,
    this.playerPageController,
    required this.panelController,
    required this.packageInfo,
    this.currentPlaylist,
    this.currentQueueIndex,
  });

  @override
  List<Object?> get props => [
        config,
        miniPlayerPageController,
        panelController,
        playerPageController,
        packageInfo,
        currentPlaylist,
        currentQueueIndex,
      ];

  ConfigLoaded copyWith({
    AppConfig? config,
    CarouselController? miniPlayerPageController,
    CarouselController? playerPageController,
    PanelController? panelController,
    PackageInfo? packageInfo,
    MediaPlaylist? currentPlaylist,
    int? currentQueueIndex,
  }) {
    return ConfigLoaded(
      config: config ?? this.config,
      miniPlayerPageController:
          miniPlayerPageController ?? this.miniPlayerPageController,
      playerPageController: playerPageController ?? this.playerPageController,
      panelController: panelController ?? this.panelController,
      packageInfo: packageInfo ?? this.packageInfo,
      currentPlaylist: currentPlaylist ?? this.currentPlaylist,
      currentQueueIndex: currentQueueIndex ?? this.currentQueueIndex,
    );
  }

  PlayableMedia? get currentMedia {
    if (currentPlaylist == null || currentQueueIndex == null) return null;
    return currentPlaylist?.mediaItems?.elementAtOrNull(currentQueueIndex ?? 0);
  }
}
