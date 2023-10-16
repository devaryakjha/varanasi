import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';
import 'package:varanasi_mobile_app/utils/extensions/router.dart';
import 'package:varanasi_mobile_app/utils/helpers/get_app_context.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';

part 'session_state.dart';

class SessionCubit extends AppCubit<SessionState> {
  SessionCubit() : super(UnAuthenticated());

  final _googleSignIn = GoogleSignIn();

  final _logger = Logger.instance;

  final _auth = FirebaseAuth.instance;

  @override
  FutureOr<void> init() {
    _auth.userChanges().listen((user) {
      if (user == null) {
        emit(UnAuthenticated());
      } else {
        emit(Authenticated(user: user));
      }
    });
    stream.distinct().listen((state) {
      if (state is! Authenticated) {
        return appContext.go(AppRoutes.authentication.path);
      }
      if ([AppRoutes.authentication.path]
          .contains(appContext.routerState.matchedLocation)) {
        return appContext.go(AppRoutes.home.path);
      }
    });
  }

  Future<void> continueWithGoogle() async {
    emit(Authenticating());
    try {
      final account = await _googleSignIn.signIn();
      final authentication = await account?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: authentication?.accessToken,
        idToken: authentication?.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      _logger.d(userCredential.user?.toString());
    } catch (e) {
      _logger.d(e.toString());
    }
  }
}
