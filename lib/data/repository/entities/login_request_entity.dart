// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginRequestEntity {
  final String? email;
  final String? password;
  final String? fcmToken;
  final String? uType;
  final String? deviceUUID;

  LoginRequestEntity(
      {this.email, this.password, this.fcmToken, this.uType, this.deviceUUID});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'fcm_token': fcmToken,
      'u_type': uType,
      'device_uuid': deviceUUID,
    };
  }

  factory LoginRequestEntity.fromMap(Map<String, dynamic> map) {
    return LoginRequestEntity(
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      fcmToken: map['fcm_token'] != null ? map['fcm_token'] as String : null,
      uType: map['u_type'] != null ? map['u_type'] as String : null,
      deviceUUID:
          map['device_uuid'] != null ? map['device_uuid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequestEntity.fromJson(String source) =>
      LoginRequestEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
