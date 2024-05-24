import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  static ThemeMode of(BuildContext context, {bool listen = false}) {
    if (listen) {
      return context.watch<ThemeCubit>().state;
    } else {
      return context.read<ThemeCubit>().state;
    }
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    return ThemeMode.values.firstWhere(
      (element) => element.name == json['theme_mode'],
      orElse: () => ThemeMode.system,
    );
  }

  @override
  Map<String, dynamic> toJson(ThemeMode state) {
    return {
      'theme_mode': state.name,
    };
  }

  void toggle() {
    switch (state) {
      case ThemeMode.system:
        emit(ThemeMode.light);
      case ThemeMode.light:
        emit(ThemeMode.dark);
      case ThemeMode.dark:
        emit(ThemeMode.system);
    }
  }
}
