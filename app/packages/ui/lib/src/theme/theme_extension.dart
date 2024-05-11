import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/theme/theme_cubit.dart';

extension ThemeCubitExtension on BuildContext {
  ThemeMode get themeMode => read<ThemeCubit>().state;
}
