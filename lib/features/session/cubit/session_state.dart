part of 'session_cubit.dart';

sealed class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

final class UnAuthenticated extends SessionState {}

final class Authenticated extends SessionState {
  final User user;

  const Authenticated({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
