// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}

class FetchUserData extends UserEvent {
  final Completer? completer;

  const FetchUserData({this.completer});

  @override
  List<Object?> get props => [completer];
}
