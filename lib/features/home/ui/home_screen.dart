import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/home/bloc/home_bloc.dart';

import 'home_widgets/home_loader.dart';
import 'home_widgets/trending/trending.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final (loading, modules) = context.select(
      (HomeBloc value) => (value.state.isLoading, value.state.modules),
    );
    return Scaffold(
      body: Visibility(
        visible: !loading,
        replacement: const HomePageLoader(),
        child: SafeArea(
          child: Column(
            children: [
              if (modules?.trending != null) ...[
                TrendingSongsList(trending: modules!.trending!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
