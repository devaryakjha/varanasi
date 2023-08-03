import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/home/bloc/home_bloc.dart';

import 'home_widgets/home_loader.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loading = context.select((HomeBloc value) => value.state.isLoading);
    return Scaffold(
      body: Visibility(
        visible: !loading,
        replacement: const HomePageLoader(),
        child: const SizedBox.shrink(),
      ),
    );
  }
}
