import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pet_style/core/helpers/log_helpers.dart';
import 'package:pet_style/core/secrets/app_secrets.dart';
import 'package:pet_style/core/services/storage_services.dart';
import 'package:pet_style/core/values/constants.dart';
import 'package:pet_style/data/model/auth_response/auth_response.dart';
import 'package:pet_style/data/model/user/user.dart';
import 'package:pet_style/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;

  AuthRepositoryImpl({required this.dio});

  @override
  Future<AuthResponse?> login(String email, String password) async {
    try {
      final Response response = await dio.post(
        AppSecrets.loginUrl,
        data: json.encode({'email': email, 'password': password}),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      final Map<String, dynamic> data = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);

        await StorageServices.setString(
            AppConstants.STORAGE_ACCESS_TOKEN, authResponse.accessToken!);
        await StorageServices.setString(
            AppConstants.STORAGE_REFRESH_TOKEN, authResponse.refreshToken!);

        return authResponse;
      }
    } catch (e, st) {
      logHandle(e.toString(), st);
      rethrow;
    }
    return null;
  }

  @override
  Future<AuthResponse> register(User user) {
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() async {
    try {
      await StorageServices.remove(AppConstants.STORAGE_ACCESS_TOKEN);
      await StorageServices.remove(AppConstants.STORAGE_REFRESH_TOKEN);
      await StorageServices.remove(AppConstants.STORAGE_SHOW_ONBOARDING);
    } catch (e) {
      logDebug(e.toString());
      rethrow;
    }
  }

  @override
  Future<AuthResponse?> refreshToken(String oldToken) async {
    try {
      final Response response = await dio.post(
        AppSecrets.refreshTokenUrl,
        data: json.encode({'refresh_token': oldToken}),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      final Map<String, dynamic> data = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);

        await StorageServices.setString(
            AppConstants.STORAGE_ACCESS_TOKEN, authResponse.accessToken!);
        await StorageServices.setString(
            AppConstants.STORAGE_REFRESH_TOKEN, authResponse.refreshToken!);

        return authResponse;
      }
    } catch (e, st) {
      logHandle(e.toString(), st);
      rethrow;
    }
    return null;
  }

  @override
  Future<AuthResponse?> googleSignIn(String token) async {
    try {
      final Response response = await dio.post(
        AppSecrets.googleSignInUrl,
        data: {'token': token},
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          },
        ),
      );
      final Map<String, dynamic> data = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);

        await StorageServices.setString(
            AppConstants.STORAGE_ACCESS_TOKEN, authResponse.accessToken!);
        await StorageServices.setString(
            AppConstants.STORAGE_REFRESH_TOKEN, authResponse.refreshToken!);

        return authResponse;
      }
    } catch (e, st) {
      logHandle(e.toString(), st);
      rethrow;
    }
    return null;
  }
}
