// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:personal_finance_app/features/auth/domain/entities/auth_user.dart';

class ProfileUser extends AuthUser {
  final String? profileImageUrl;

  const ProfileUser({
    required super.id,
    required super.name,
    required super.email,
    this.profileImageUrl,
  });

  ProfileUser copyWith({
    String? name,
    String? profileImageUrl,
  }) {
    return ProfileUser(
      id: id,
      name: name ?? this.name,
      email: email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory ProfileUser.fromMap(Map<String, dynamic> map) {
    return ProfileUser(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profileImageUrl: map['profileImageUrl'] != null ? map['profileImageUrl'] as String : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ProfileUser.fromJson(String source) => ProfileUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
