import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserEntity extends Equatable {
  final String email;
  final String? username;
  final DateTime? dateOfBirth;
  final String? avatarUrl;
  final String phoneNumber;

  const UserEntity({
    required this.email,
    this.username,
    this.dateOfBirth,
    this.avatarUrl,
    this.phoneNumber,
  });

  static const empty = UserEntity(email: '');

  @override
  List<Object?> get props => [email, username, avatarUrl, phoneNumber];

  static const String emailFieldName = 'email';
  static const String usernameFieldName = 'username';
  static const String dateOfBirthFieldName = 'dateOfBirth';
  static const String avatarUrlFieldName = 'avatarUrl';
  static const String phoneNumberFieldName = 'phoneNumber';
}

extension on User {
  User get toUser {
    return UserEntity(
      email: email,
      avatarUrl: photoURL,
      username: displayName,
      dateOfBirth: birthday,
    );
  }
}
