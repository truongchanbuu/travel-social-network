import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String? email;
  final String? username;
  final DateTime? dateOfBirth;
  final String? avatarUrl;
  final String? phoneNumber;

  const UserEntity({
    required this.id,
    this.email,
    this.username,
    this.dateOfBirth,
    this.avatarUrl,
    this.phoneNumber,
  });

  static const empty = UserEntity(id: '');

  bool get isLoggedIn => this != empty;

  @override
  List<Object?> get props => [id, email, username, avatarUrl, phoneNumber];

  static const String idFieldName = 'id';
  static const String emailFieldName = 'email';
  static const String usernameFieldName = 'username';
  static const String dateOfBirthFieldName = 'dateOfBirth';
  static const String avatarUrlFieldName = 'avatarUrl';
  static const String phoneNumberFieldName = 'phoneNumber';
}
