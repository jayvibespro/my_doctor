import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model/user_model.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

class SessionManager {
  Future<void> setUserData(UserModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', data.id ?? 0);
    await prefs.setInt('company_id', data.companyId ?? 0);
    await prefs.setString('company_Name', data.companyName ?? '');
    await prefs.setString('full_name', data.fullName ?? '');
    await prefs.setString('email', data.email ?? '');
    await prefs.setString('phone_number', data.phoneNumber ?? '');
    await prefs.setString('username', data.userName ?? '');
    await prefs.setBool('is_first_login', data.isFirstLogin ?? false);
    await prefs.setBool('is_active', data.isActive ?? false);
    if (data.roles != null) {
      await prefs.setStringList('roles', data.roles!);
    }
  }

  Future<UserModel?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    if (id == null || id == 0) {
      return null;
    }

    return UserModel(
      id: id,
      companyId: prefs.getInt('company_id'),
      companyName: prefs.getString('company_name'),
      fullName: prefs.getString('full_name'),
      email: prefs.getString('email'),
      phoneNumber: prefs.getString('phone_number'),
      userName: prefs.getString('username'),
      isFirstLogin: prefs.getBool('is_first_login'),
      isActive: prefs.getBool('is_active'),
      roles: prefs.getStringList('roles'),
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
