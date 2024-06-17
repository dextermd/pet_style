import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pet_style/core/helpers/log_helpers.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final InternetConnection connectionChecker;

  NetworkBloc({required this.connectionChecker}) : super(NetworkInitial()) {
    on<CheckNetworkConnection>((event, emit) async {
      final hasConnection = await connectionChecker.hasInternetAccess;
      if (hasConnection) {
        logDebug('Internet connection is available');
        emit(NetworkConnected());
      } else {
        logDebug('No internet connection');
        emit(NetworkDisconnected());
      }
    });
    connectionChecker.onStatusChange.listen((status) {
      if (status == InternetStatus.connected) {
        add(CheckNetworkConnection());
      } else {
        emit(NetworkDisconnected());
      }
    });
  }
}
