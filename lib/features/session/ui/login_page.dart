import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/extensions/media_query.dart';
import 'package:varanasi_mobile_app/widgets/input_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Log in'),
      ),
      body: SizedBox(
        width: context.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  InputFormField(
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: context.colorScheme.primary),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    maxLines: 1,
                    autofillHints: const [AutofillHints.email],
                    autofocus: true,
                    inputType: InputType.email,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Password',
                    style: context.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  InputFormField(
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: context.colorScheme.primary),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    autofocus: true,
                    autofillHints: const [AutofillHints.password],
                    inputType: InputType.password,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
