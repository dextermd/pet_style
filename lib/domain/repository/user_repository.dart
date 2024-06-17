import 'package:pet_style/data/model/user/user.dart';

abstract interface class UserRepository {
    Future<User?> getUserData();
}