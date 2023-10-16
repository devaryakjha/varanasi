import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/session/cubit/session_cubit.dart';
import 'package:varanasi_mobile_app/gen/assets.gen.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/helpers/ressponsive_sizer.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      child: Scaffold(
        body: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: Device.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Assets.icon.appIconMonotone.svg(
                    placeholderBuilder: (ctx) =>
                        const SizedBox(width: 48, height: 48),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Millions of Songs.\nForever Free.",
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 36),
                  FilledButton.tonal(
                    onPressed: () {},
                    child: const Text(
                      "Sign up for free",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.facebook),
                    onPressed: context.read<SessionCubit>().continueWithGoogle,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: context.colorScheme.onBackground,
                    ),
                    label: const Center(
                      child: Text(
                        "Continue with Google",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: context.colorScheme.onBackground,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Log in",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
