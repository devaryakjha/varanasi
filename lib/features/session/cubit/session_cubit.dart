import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';

part 'session_state.dart';

class SessionCubit extends AppCubit<SessionState> {
  SessionCubit() : super(UnAuthenticated());

  final _googleSignIn = GoogleSignIn();

  final _logger = Logger.instance;

  final _auth = FirebaseAuth.instance;

  @override
  FutureOr<void> init() {
    _auth.userChanges().map((user) {
      return user == null ? UnAuthenticated() : Authenticated(user: user);
    }).listen(emit);
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
      await _googleSignIn.signOut();
      _logger.d(e.toString());
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(Authenticating());
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _logger.d(userCredential.user?.toString());
    } catch (e) {
      _logger.d(e.toString());
    }
  }

  Future<void> signOut() async {
    emit(Authenticating());
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      _logger.d(e.toString());
    }
  }
}
