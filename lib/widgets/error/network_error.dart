import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/gen/assets.gen.dart';
import 'package:varanasi_mobile_app/utils/exceptions/network_exception.dart';
import 'package:varanasi_mobile_app/utils/extensions/ressponsive_sizer.dart';

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
      body: Stack(
        children: [
          Assets.images.error.somethingWentWrong.image(
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            bottom: 10.h,
            left: 16.w,
            right: 16.w,
            child: ElevatedButton(
              onPressed: retryCallback,
              child: Text(retryText),
            ),
          )
        ],
      ),
    );
  }
}
