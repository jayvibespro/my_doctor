import 'package:cloud_firestore/cloud_firestore.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

class UserModel {
  String? id;
  String? userId;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? speciality;
  bool? isActive;
  String? accountType;
  String? createdAt;
  String? imageUrl;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.accountType,
    this.userId,
    this.speciality,
    this.isActive,
    this.createdAt,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'email': email,
      'name': name,
      'phone': phone,
      'account_type': accountType,
      'speciality': speciality,
      'image_url': imageUrl,
      'is_active': isActive,
      'created_at': createdAt,
    };
  }

  Map<String, dynamic> toMapForUpdate() {
    return {
      'name': name,
      'phone': phone,
      'speciality': speciality,
      'image_url': imageUrl,
      'is_active': isActive,
    };
  }

  Map<String, dynamic> toMapWithPassword() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'account_type': accountType,
      'password': password,
      'speciality': speciality,
      'image_url': imageUrl,
      'is_active': isActive,
      'created_at': createdAt,
    };
  }

  factory UserModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> doc}) {
    return UserModel(
      id: doc.id,
      userId: doc.data()?['user_id'],
      name: doc.data()?['name'],
      email: doc.data()?['email'],
      phone: doc.data()?['phone'],
      accountType: doc.data()?['account_type'],
      speciality: doc.data()?['speciality'],
      imageUrl: doc.data()?['image_url'],
      isActive: doc.data()?['is_active'],
      createdAt: doc.data()?['created_at'],
    );
  }
}
