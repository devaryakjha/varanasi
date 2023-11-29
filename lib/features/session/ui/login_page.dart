import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/features/session/cubit/session_cubit.dart';
import 'package:varanasi_mobile_app/utils/app_snackbar.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool isFormValid = false;
  bool isPasswordVisible = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Log in'),
        titleTextStyle: context.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      body: SizedBox(
        width: context.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: _buildForm(context),
        ),
      ),
    );
  }

  Form _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () {
        final isValid = _formKey.currentState?.validate() ?? false;
        if (isValid != isFormValid) {
          setState(() {
            isFormValid = isValid;
          });
        }
      },
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            FilledInputField(
              controller: _emailController,
              context: context,
              maxLines: 1,
              autofillHints: const [AutofillHints.email],
              autofocus: true,
              inputType: InputType.email,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 24),
            Text(
              'Password',
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            FilledInputField(
              controller: _passwordController,
              context: context,
              autofillHints: const [AutofillHints.password],
              inputType: InputType.password,
              maxLines: 1,
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(suffixIcon: _buildSuffix()),
            ),
            const SizedBox(height: 24),
            LoginButton(
              isFormValid: isFormValid,
              emailController: _emailController,
              passwordController: _passwordController,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildSuffix() {
    return GestureDetector(
      onTap: () => setState(() {
        isPasswordVisible = !isPasswordVisible;
      }),
      child: Icon(
        isPasswordVisible
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        size: 24,
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.isFormValid,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final bool isFormValid;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    final isGuestUser = context.select((SessionCubit cubit) =>
        cubit.state is Authenticated && (cubit.state as Authenticated).isGuest);
    return Align(
      alignment: Alignment.center,
      child: FilledButton.tonal(
        onPressed: isFormValid
            ? () async {
                if (isGuestUser) {
                  final connected =
                      await context.read<SessionCubit>().linkEmailPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                  if (connected && context.mounted && context.canPop()) {
                    context.pop();
                  }
                  AppSnackbar.show("Account linked successfully.");
                } else {
                  context.read<SessionCubit>().signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                }
              }
            : null,
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 36,
          ),
        ),
        child: Text(
          isGuestUser ? "Link" : 'Log in',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
