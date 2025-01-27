import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model/user_model.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

class SessionManager {
  Future<void> setUserData(UserModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', data.id ?? "");
    await prefs.setString('user_id', data.userId ?? "");
    await prefs.setString('account_type', data.accountType ?? "");
    await prefs.setString('image_url', data.imageUrl ?? '');
    await prefs.setString('full_name', data.name ?? '');
    await prefs.setString('email', data.email ?? '');
    await prefs.setString('phone_number', data.phone ?? '');
    await prefs.setString('created_at', data.createdAt ?? '');
    await prefs.setString('speciality', data.speciality ?? '');
    await prefs.setBool('is_active', data.isActive ?? false);
  }

  Future<UserModel?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    if (id == null || id == "") {
      return null;
    }

    return UserModel(
      id: id,
      userId: prefs.getString('user_id'),
      accountType: prefs.getString('account_type'),
      imageUrl: prefs.getString('image_url'),
      name: prefs.getString('full_name'),
      email: prefs.getString('email'),
      phone: prefs.getString('phone_number'),
      speciality: prefs.getString('speciality'),
      isActive: prefs.getBool('is_active'),
      createdAt: prefs.getString('created_at'),
    );
  }

  Future<void> setAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
