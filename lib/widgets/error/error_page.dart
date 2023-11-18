import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/utils/exceptions/app_exception.dart';
import 'package:varanasi_mobile_app/utils/exceptions/network_exception.dart';

import 'network_error.dart';

typedef RetryCallback = void Function();

class ErrorPage<E extends AppException> extends StatelessWidget {
  final E? error;
  final RetryCallback retryCallback;

  const ErrorPage({
    super.key,
    required this.error,
    required this.retryCallback,
  });

  @override
  Widget build(BuildContext context) {
    return switch (error) {
      (NetworkException _) => NetworkErrorPage(
          error: error as NetworkException,
          retryCallback: retryCallback,
        ),
      _ => const Placeholder(),
    };
  }
}
