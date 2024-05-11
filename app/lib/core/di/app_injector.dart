import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class AppInjector extends StatefulWidget {
  const AppInjector({
    required this.builder,
    super.key,
  });

  final WidgetBuilder builder;

  @override
  State<AppInjector> createState() => _AppInjectorState();
}

class _AppInjectorState extends State<AppInjector> {
  late final ThemeCubit _themeCubit;

  void _initValues() {
    _themeCubit = ThemeCubit();
  }

  @override
  void initState() {
    super.initState();
    _initValues();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _themeCubit),
      ],
      child: Builder(
        builder: widget.builder,
      ),
    );
  }
}
