import 'package:pet_style/data/model/auth_response/auth_response.dart';
import 'package:pet_style/data/model/user/user.dart';

abstract interface class AuthRepository {
  Future<AuthResponse?> login(String email, String password);
  Future<AuthResponse> register(User user);
  Future<AuthResponse?> refreshToken(String oldToken);
  Future<void> logOut();

  Future<AuthResponse?> googleSignIn(String idToken);
}
