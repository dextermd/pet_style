import 'package:get_it/get_it.dart';
import 'package:pet_style/core/helpers/log_helper.dart';
import 'package:pet_style/core/services/storage_services.dart';
import 'package:pet_style/core/values/constants.dart';
import 'package:pet_style/data/model/message/message.dart';
import 'package:pet_style/domain/repository/auth_repository.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;
  final AuthRepository authRepository = GetIt.I<AuthRepository>();

  void connect(String userId) async {
    final token = StorageServices.getString(AppConstants.STORAGE_ACCESS_TOKEN);

    socket = IO.io(
        'http://localhost:3002',
        IO.OptionBuilder().setTransports(['websocket']).setQuery({
          'userId': userId,
          'token': token,
        }).build());

    socket.connect();

    socket.on('token_expired', (_) async {
      _handleTokenExpired();
    });

    socket.onConnect((_) {
      logDebug('Socket connected');
    });

    socket.onConnectError((error) {
      logDebug('Connection error: $error');
    });

    socket.onReconnect((attempt) {
      logDebug('Socket Reconnecting: attempt $attempt');
    });

    socket.onDisconnect((_) {
      logDebug('Socket disconnected');
    });
  }

  sendMessage(Message message) async {
    socket.emit('msgToServer', message.toJson());
  }

  updateMessageStatus(String messageId, int status) {
    socket.emit('updateMessageStatus', {
      'messageId': messageId,
      'status': status,
    });
  }

  void disconnect() {
    socket.disconnect();
  }

  void _handleTokenExpired() async {
    final refreshToken =
        StorageServices.getString(AppConstants.STORAGE_REFRESH_TOKEN);
    if (refreshToken != null) {
      try {
        final newTokens = await authRepository.refreshToken(refreshToken);
        if (newTokens != null) {
          await StorageServices.setString(
              AppConstants.STORAGE_ACCESS_TOKEN, newTokens.accessToken!);
          await StorageServices.setString(
              AppConstants.STORAGE_REFRESH_TOKEN, newTokens.refreshToken!);

          socket.disconnect();
          socket.connect();
          logDebug('Token refreshed from socket service');
        }
      } catch (e) {
        logDebug('Error refreshing token: $e');
      }
    }
  }
}
