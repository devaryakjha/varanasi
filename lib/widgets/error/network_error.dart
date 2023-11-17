import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/utils/exceptions/network_exception.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

import 'error_page.dart';

class NetworkErrorPage extends ErrorPage<NetworkException> {
  const NetworkErrorPage({
    super.key,
    required super.error,
    required super.retryCallback,
    this.retryText = 'Retry',
  });

  final String retryText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Something went wrong",
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Please check your internet connection and try again",
              style: context.textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: retryCallback,
              child: Text(retryText),
            )
          ],
        ),
      ),
    );
  }
}
