import 'package:dio/dio.dart';
import 'package:pet_style/core/secrets/app_secrets.dart';
import 'package:pet_style/data/model/user/user.dart';
import 'package:pet_style/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final Dio dio;

  UserRepositoryImpl({required this.dio});

  @override
  Future<User?> getUserData() async {
    try {
      final response = await dio.get(
        AppSecrets.meUrl,
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        return null;
      } 
    } catch (e) {
      throw Exception('Failed to load user data');
    }
  }
}

