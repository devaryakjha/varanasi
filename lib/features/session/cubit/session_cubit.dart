import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:varanasi_mobile_app/features/user-library/cubit/user_library_cubit.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';
import 'package:varanasi_mobile_app/utils/app_snackbar.dart';
import 'package:varanasi_mobile_app/utils/helpers/get_app_context.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';
import 'package:varanasi_mobile_app/utils/services/firestore_service.dart';

part 'session_state.dart';

class SessionCubit extends AppCubit<SessionState> {
  SessionCubit() : super(UnAuthenticated());

  final _googleSignIn = GoogleSignIn();

  final _logger = Logger.instance;

  final _auth = FirebaseAuth.instance;

  StreamSubscription? _userListener;

  @override
  FutureOr<void> init() {
    _auth.userChanges().map((user) {
      return user == null ? UnAuthenticated() : Authenticated(user: user);
    }).listen((state) {
      if (state is Authenticated) {
        FirestoreService.init();
        _userListener = FirestoreService.userDocument
            ?.collection("preferences")
            .doc("preferences")
            .snapshots()
            .listen((event) {
          final preferences = event.data();
          emit(state.copyWith(
            userData: preferences == null
                ? const CustomUserData()
                : CustomUserData.fromJson(preferences),
          ));
        });
        appContext.read<UserLibraryCubit>().setupListeners();
      } else {
        FirestoreService.dispose();
        _userListener?.cancel();
        appContext.read<UserLibraryCubit>().disposeListeners();
      }
      emit(state);
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
    } on FirebaseAuthException catch (e) {
      emit(UnAuthenticated());
      _handleException(e);
    } catch (e) {
      await _googleSignIn.signOut();
      emit(UnAuthenticated());
      _logger.d(e.toString());
    }
  }

  Future<void> linkGoogleAccount() async {
    final prevState = state;
    try {
      final account = await _googleSignIn.signIn();
      final authentication = await account?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: authentication?.accessToken,
        idToken: authentication?.idToken,
      );
      final user = _auth.currentUser;
      await user?.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      emit(prevState);
      await _googleSignIn.signOut();
      _handleException(e);
    } catch (e) {
      emit(prevState);
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
      emit(UnAuthenticated());
      _handleException(e);
    } catch (e) {
      emit(UnAuthenticated());
      _logger.d(e.toString());
    }
  }

  Future<bool> linkEmailPassword({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final user = _auth.currentUser;
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      final ucredential = await user?.linkWithCredential(credential);
      if (ucredential?.user != null) {
        if (name != null) {
          unawaited(ucredential?.user?.updateDisplayName(name));
        }
        emit((state as Authenticated).copyWith(user: ucredential!.user!));
      }
      return true;
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      _logger.d(e.toString());
    }
    return false;
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
      emit(UnAuthenticated());
      _handleException(e);
    } catch (e) {
      emit(UnAuthenticated());
      _logger.d(e.toString());
    }
  }

  Future<void> signInAnonymously() async {
    emit(Authenticating());
    try {
      final userCredential = await _auth.signInAnonymously();
      _logger.d(userCredential.user?.toString());
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      _logger.d(e.toString());
    }
  }

  Future<void> updateName(String name) async {
    try {
      final user = _auth.currentUser;
      await user?.updateDisplayName(name);
      _logger.d(user?.toString());
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
      'credential-already-in-use' =>
        'This credential is already associated with a different user account.',
      (_) => 'An undefined Error happened.'
    };
    AppSnackbar.show(message);
  }

  void incrementCustomPlaylistIndex() {
    final state = this.state;
    if (state is Authenticated) {
      FirestoreService.userDocument
          ?.collection("preferences")
          .doc("preferences")
          .get()
          .then((value) {
        if (value.exists) {
          FirestoreService.userDocument
              ?.collection("preferences")
              .doc("preferences")
              .update({
            "customPlaylistIndex": state.userData.customPlaylistIndex + 1,
          });
        } else {
          FirestoreService.userDocument
              ?.collection("preferences")
              .doc("preferences")
              .set(state.userData.toJson());
        }
      });
    }
  }
}
