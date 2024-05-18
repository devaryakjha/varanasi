import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi/app/features/discover/data/data_sources/discovery_remote_data_source_api.dart';
import 'package:varanasi/app/features/discover/data/repositories/discover_repository_impl.dart';
import 'package:varanasi/app/features/discover/domain/repositories/discover_repository.dart';
import 'package:varanasi/app/shared/shared.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    required this.navigationShell,
    required this.children,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final DiscoverRepository _discoverRepository;

  @override
  void initState() {
    super.initState();
    _discoverRepository = DiscoverRepositoryImpl(
      remoteDataSource: DiscoveryRemoteDataSourceApi(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _discoverRepository),
      ],
      child: Scaffold(
        body: BrightnessOverlay.adaptive(
          child: SafeArea(
            child: widget.children[widget.navigationShell.currentIndex],
          ),
        ),
      ),
    );
  }
}
