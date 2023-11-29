import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/features/session/cubit/session_cubit.dart';
import 'package:varanasi_mobile_app/utils/app_snackbar.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/widgets/input_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool isFormValid = false;
  bool isPasswordVisible = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
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
        title: const Text('Create Account'),
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
            _buildTitle(context, 'What should we call you?'),
            const SizedBox(height: 8),
            FilledInputField(
              controller: _nameController,
              context: context,
              maxLines: 1,
              autofillHints: const [
                AutofillHints.name,
                AutofillHints.newUsername
              ],
              autofocus: true,
              inputType: InputType.username,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 24),
            _buildTitle(context, 'What\'s your email?'),
            const SizedBox(height: 8),
            FilledInputField(
              controller: _emailController,
              context: context,
              maxLines: 1,
              autofillHints: const [AutofillHints.email],
              inputType: InputType.email,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 24),
            _buildTitle(context, 'Create a password'),
            const SizedBox(height: 8),
            FilledInputField(
              controller: _passwordController,
              context: context,
              autofillHints: const [AutofillHints.newPassword],
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
              nameController: _nameController,
            ),
          ],
        ),
      ),
    );
  }

  Text _buildTitle(BuildContext context, String text) {
    return Text(
      text,
      style: context.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
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
    required this.emailController,
    required this.passwordController,
    required this.nameController,
  });

  final bool isFormValid;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    final isGuestUser = context.select((SessionCubit cubit) =>
        cubit.state is Authenticated && (cubit.state as Authenticated).isGuest);
    final authenticating = context.select((SessionCubit cubit) {
      return cubit.state is Authenticating;
    });
    return Align(
      alignment: Alignment.center,
      child: FilledButton.tonal(
        onPressed: isFormValid && !authenticating
            ? () async {
                if (isGuestUser) {
                  final connected =
                      await context.read<SessionCubit>().linkEmailPassword(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                          );
                  if (connected && context.mounted && context.canPop()) {
                    context.pop();
                  }
                  AppSnackbar.show("Account linked successfully.");
                } else {
                  context.read<SessionCubit>().signUpWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                        name: nameController.text,
                      );
                }
              }
            : null,
        style: FilledButton.styleFrom(
          padding: authenticating
              ? const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                )
              : const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 36,
                ),
        ),
        child: Visibility(
          visible: !authenticating,
          replacement: const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(),
          ),
          child: Text(
            isGuestUser ? 'Link your account' : 'Create Account',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
