import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String email;
  final String? username;
  final DateTime? dateOfBirth;
  final String? avatarUrl;

  const UserEntity({
    required this.email,
    this.username,
    this.dateOfBirth,
    this.avatarUrl,
  });

  static const empty = UserEntity(email: '');

  @override
  List<Object?> get props => [
        email,
        username,
        avatarUrl,
      ];

  static const String emailFieldName = 'email';
  static const String usernameFieldName = 'username';
  static const String dateOfBirthFieldName = 'dateOfBirth';
  static const String avatarUrlFieldName = 'avatarUrl';
}
