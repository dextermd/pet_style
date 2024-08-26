import 'package:dio/dio.dart';
import 'package:pet_style/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final Dio dio;

  ChatRepositoryImpl({required this.dio});
}
