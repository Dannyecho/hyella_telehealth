// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignInState {
  final String email;
  final String password;
  final String userType;
  final bool isStaff;
  final String fcmToken;

  SignInState({
    this.email = '',
    this.password = '',
    this.userType = '',
    this.isStaff = false,
    this.fcmToken = '',
  });

  SignInState copyWith({
    String? email,
    String? password,
    String? userType,
    bool? isStaff,
    String? fcmToken,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      userType: userType ?? this.userType,
      isStaff: isStaff ?? this.isStaff,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}
