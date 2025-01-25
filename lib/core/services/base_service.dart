import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/api_response_model.dart';
import '../utils/constants/urls.dart';
import '../utils/session_manager.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

class BaseService {
  Future<Map<String, String>> _buildHeaders() async {
    String token = await _fetchToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    if (kDebugMode) {
      print("HEADERS: $headers");
    }

    return headers;
  }

  Future<String> _fetchToken() async {
    await SessionManager().getAccessToken();
    return await SessionManager().getAccessToken() ?? "";
  }

  Future<ApiResponseModel<T?>> get<T>(String endpoint,
      {T Function(dynamic)? fromJson}) async {
    String url = '$baseUrl/$endpoint';
    if (kDebugMode) {
      print("====================   START API CALL   ====================");
      print("URL: $url");
    }
    return await _request<T>(
      http.get(Uri.parse(url), headers: await _buildHeaders()),
      fromJson: fromJson,
    );
  }

  Future<ApiResponseModel<T?>> post<T>(String endpoint,
      {Map<String, dynamic>? body, T Function(dynamic)? fromJson}) async {
    String url = '$baseUrl/$endpoint';

    if (kDebugMode) {
      print("====================   START API CALL   ====================");
      print("URL: $url");
      print("PAYLOAD: $body");
    }
    return await _request<T>(
      http.post(
        Uri.parse(url),
        headers: await _buildHeaders(),
        body: jsonEncode(body),
      ),
      fromJson: fromJson,
    );
  }

  Future<ApiResponseModel<T?>> put<T>(String endpoint,
      {Map<String, dynamic>? body, T Function(dynamic)? fromJson}) async {
    String url = '$baseUrl/$endpoint';
    if (kDebugMode) {
      print("====================   START API CALL   ====================");
      print("URL: $url");
      print("BODY: $body");
    }
    return await _request<T>(
      http.put(
        Uri.parse(url),
        headers: await _buildHeaders(),
        body: jsonEncode(body),
      ),
      fromJson: fromJson,
    );
  }

  Future<ApiResponseModel<T?>> delete<T>(String endpoint,
      {Map<String, dynamic>? body, T Function(dynamic)? fromJson}) async {
    String url = '$baseUrl/$endpoint';

    if (kDebugMode) {
      print("====================   START API CALL   ====================");
      print("URL: $url");
      print("BODY: $body");
    }
    return await _request<T>(
      http.delete(
        Uri.parse(url),
        headers: await _buildHeaders(),
        body: jsonEncode(body),
      ),
      fromJson: fromJson,
    );
  }

  Future<ApiResponseModel<T?>> _request<T>(Future<http.Response> futureResponse,
      {T Function(dynamic)? fromJson}) async {
    try {
      var response = await futureResponse;

      if (kDebugMode) {
        print("STATUS_CODE: ${response.statusCode}");
        log("RESPONSE: ${response.body}");
        print("====================   END API CALL   ====================");
      }

      var data = jsonDecode(response.body);

      if (response.statusCode == 401) {
        // Get.offAll(() => const SignInScreen());

        return ApiResponseModel(
          data: null,
          statusCode: response.statusCode,
          message: data['message'] ??
              data['error'] ??
              'Session expired. Please sign in to continue.',
        );
      }

      if (response.statusCode == 502) {
        return ApiResponseModel(
          data: null,
          statusCode: response.statusCode,
          message: '502 Bad Gateway',
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        String message = 'Success';
        if (data is Map<String, dynamic> && data.containsKey("message")) {
          message = data['message'];
        }
        if (fromJson != null) {
          return ApiResponseModel(
            data: fromJson(data),
            statusCode: response.statusCode,
            message: message,
          );
        }
        return ApiResponseModel(
          data: jsonDecode(response.body) as T?,
          statusCode: response.statusCode,
          message: message,
        );
      } else {
        return ApiResponseModel(
          data: null,
          statusCode: response.statusCode,
          message: data['message'] ??
              data['error'] ??
              'An error occurred with status code: ${response.statusCode}',
        );
      }
    } on SocketException catch (_) {
      return ApiResponseModel(
          data: null, statusCode: 600, message: 'No Internet connection');
    } on FormatException catch (_) {
      return ApiResponseModel(
        data: null,
        statusCode: 502,
        message: "502 Bad Gateway or Bad response format",
      );
    } on HttpException catch (_) {
      return ApiResponseModel(
        data: null,
        statusCode: 600,
        message: "Failed to connect to the server",
      );
    } on TimeoutException catch (_) {
      return ApiResponseModel(
        data: null,
        statusCode: 600,
        message: "Request timeout",
      );
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
      return ApiResponseModel(data: null, statusCode: 600, message: "$e");
    }
  }
}
