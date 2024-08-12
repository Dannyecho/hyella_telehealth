// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class SignInEvent {
  const SignInEvent();
}

class EmailEvent extends SignInEvent {
  final String email;
  const EmailEvent({
    required this.email,
  });
}

class PasswordEvent extends SignInEvent {
  final String password;
  const PasswordEvent({
    required this.password,
  });
}

class IsStaffEvent extends SignInEvent {
  final bool isStaff;
  const IsStaffEvent({
    required this.isStaff,
  });
}

class FcmTokenEvent extends SignInEvent {
  final String fcmToken;
  const FcmTokenEvent({
    required this.fcmToken,
  });
}
