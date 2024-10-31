import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    super.email,
    super.username,
    super.avatarUrl,
    super.phoneNumber,
    super.dateOfBirth,
    super.createdAt,
    super.updatedAt,
    super.isVerified,
  });

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      username: username,
      avatarUrl: avatarUrl,
      phoneNumber: phoneNumber,
      isVerified: isVerified,
      createdAt: createdAt,
      dateOfBirth: dateOfBirth,
      updatedAt: updatedAt,
    );
  }

  @override
  UserModel copyWith({
    String? id,
    String? email,
    String? username,
    DateTime? dateOfBirth,
    String? avatarUrl,
    String? phoneNumber,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      username: entity.username,
      avatarUrl: entity.avatarUrl,
      phoneNumber: entity.phoneNumber,
      isVerified: entity.isVerified,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      dateOfBirth: entity.dateOfBirth,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
