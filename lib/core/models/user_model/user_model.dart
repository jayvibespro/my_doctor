import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

@JsonSerializable()
class UserModel {
  final String? id;
  final String? createdAt;
  final String? imageUrl;
  final String? fullName;
  final String? email;
  final String? speciality;
  String? phoneNumber;
  String? password;
  final bool? isFirstLogin;
  final bool? isActive;
  final String? accountType;

  UserModel({
    this.accountType,
    this.id,
    this.createdAt,
    this.imageUrl,
    this.fullName,
    this.email,
    this.speciality,
    this.phoneNumber,
    this.password,
    this.isFirstLogin,
    this.isActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
