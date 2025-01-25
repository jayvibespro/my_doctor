import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

@JsonSerializable()
class UserModel {
  final int? id;
  final int? companyId;
  final String? companyName;
  final String? fullName;
  final String? email;
  final String? gender;
  String? phoneNumber;
  String? password;

  @JsonKey(name: 'username')
  final String? userName;
  String? currentPassword;
  String? newPassword;
  String? confirmPassword;
  final bool? isFirstLogin;
  final bool? isActive;

  @JsonKey(name: 'roles')
  final List<String>? roles;

  UserModel({
    this.id,
    this.companyId,
    this.companyName,
    this.fullName,
    this.email,
    this.gender,
    this.phoneNumber,
    this.password,
    this.currentPassword,
    this.newPassword,
    this.confirmPassword,
    this.userName,
    this.isFirstLogin,
    this.isActive,
    this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
