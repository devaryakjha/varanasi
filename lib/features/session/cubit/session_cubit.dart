import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';

part 'session_state.dart';

class SessionCubit extends AppCubit<SessionState> {
  SessionCubit() : super(UnAuthenticated());

  @override
  FutureOr<void> init() {}
}
