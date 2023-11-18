import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/features/session/cubit/session_cubit.dart';
import 'package:varanasi_mobile_app/features/user-library/cubit/user_library_cubit.dart';
import 'package:varanasi_mobile_app/utils/constants/constants.dart';
import 'package:varanasi_mobile_app/utils/router.dart';
import 'package:varanasi_mobile_app/widgets/responsive_sizer.dart';

import 'cubits/config/config_cubit.dart';
import 'cubits/download/download_cubit.dart';
import 'cubits/player/player_cubit.dart';
import 'utils/theme.dart';

class Varanasi extends StatelessWidget {
  const Varanasi({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  lazy: false, create: (_) => UserLibraryCubit()..init()),
              BlocProvider(lazy: false, create: (_) => DownloadCubit()..init()),
              BlocProvider(
                lazy: false,
                create: (context) => ConfigCubit()..init(),
              ),
              BlocProvider(
                lazy: false,
                create: (ctx) => MediaPlayerCubit()..init(),
              ),
              BlocProvider(lazy: false, create: (ctx) => LibraryCubit()),
              BlocProvider(lazy: false, create: (_) => SessionCubit()..init()),
            ],
            child: Builder(builder: (context) {
              final scheme = context.select(
                (ConfigCubit cubit) => cubit.configOrNull?.config.scheme,
              );
              return MaterialApp.router(
                title: AppStrings.appName,
                darkTheme: appTheme(scheme),
                themeMode: ThemeMode.dark,
                routerConfig: routerConfig,
                debugShowCheckedModeBanner: false,
              );
            }),
          );
        },
      ),
    );
  }
}
