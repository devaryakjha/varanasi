import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';
import 'package:varanasi_mobile_app/utils/app_snackbar.dart';
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
    } on FirebaseAuthException catch (e) {
      _handleException(e);
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
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      _logger.d(e.toString());
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(Authenticating());
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(name);
      _logger.d(userCredential.user?.toString());
    } on FirebaseAuthException catch (e) {
      _handleException(e);
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

  void _handleException(FirebaseAuthException exception) {
    final message = switch (exception.code) {
      'invalid-email' => 'The email address is not valid.',
      'user-disabled' =>
        'The user corresponding to the given email has been disabled.',
      'user-not-found' =>
        'The user corresponding to the given email does not exist.',
      'wrong-password' =>
        'The password is invalid for the given email, or the account corresponding to the email does not have a password set.',
      'email-already-in-use' =>
        'The email address is already in use by another account.',
      'operation-not-allowed' =>
        'Indicates that Email & Password accounts are not enabled.',
      'weak-password' => 'The password must be 6 characters long or more.',
      (_) => 'An undefined Error happened.'
    };
    AppSnackbar.show(message);
  }
}
