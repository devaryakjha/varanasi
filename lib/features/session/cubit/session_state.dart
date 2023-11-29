// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'session_cubit.dart';

sealed class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

final class UnAuthenticated extends SessionState {}

final class Authenticating extends SessionState {}

final class CustomUserData extends Equatable {
  final int customPlaylistIndex;

  const CustomUserData({
    this.customPlaylistIndex = 0,
  });

  CustomUserData copyWith({
    int? customPlaylistIndex,
  }) {
    return CustomUserData(
      customPlaylistIndex: customPlaylistIndex ?? this.customPlaylistIndex,
    );
  }

  factory CustomUserData.fromJson(Map<String, dynamic> json) {
    return CustomUserData(
      customPlaylistIndex: json['customPlaylistIndex'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customPlaylistIndex': customPlaylistIndex,
    };
  }

  @override
  List<Object> get props => [customPlaylistIndex];
}

final class Authenticated extends SessionState {
  final User user;
  final CustomUserData userData;

  const Authenticated({
    required this.user,
    this.userData = const CustomUserData(),
  });

  @override
  List<Object> get props => [user, userData];

  Authenticated copyWith({
    User? user,
    CustomUserData? userData,
  }) {
    return Authenticated(
      user: user ?? this.user,
      userData: userData ?? this.userData,
    );
  }

  bool get isGuest => user.isAnonymous;
}
