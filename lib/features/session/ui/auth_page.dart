import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/features/session/cubit/session_cubit.dart';
import 'package:varanasi_mobile_app/gen/assets.gen.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/helpers/ressponsive_sizer.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  style: _buildButtonStyles(),
                  onPressed: () => context.pushNamed(AppRoutes.signup.name),
                  child: _buildText(context, "Sign up for free"),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  icon: Assets.icon.google.svg(width: 24, height: 24),
                  onPressed: context.read<SessionCubit>().continueWithGoogle,
                  style: _buildButtonStyles(),
                  label: Center(
                    child: _buildText(context, "Continue with Google"),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => context.pushNamed(AppRoutes.login.name),
                  child: _buildText(context, "Log in"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle _buildButtonStyles() {
    return OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    );
  }

  Text _buildText(BuildContext context, String text) {
    return Text(
      text,
      style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
