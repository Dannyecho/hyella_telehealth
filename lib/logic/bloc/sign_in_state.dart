// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignInState {
  final String email;
  final String password;
  final String userType;
  final bool isStaff;
  final String fcmToken;
  final bool peak;

  SignInState({
    required this.email,
    required this.password,
    required this.userType,
    required this.isStaff,
    required this.fcmToken,
    required this.peak,
  });

  SignInState copyWith({
    String? email,
    String? password,
    String? userType,
    bool? isStaff,
    String? fcmToken,
    bool? peak,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      userType: userType ?? this.userType,
      isStaff: isStaff ?? this.isStaff,
      fcmToken: fcmToken ?? this.fcmToken,
      peak: peak ?? this.peak,
    );
  }
}
