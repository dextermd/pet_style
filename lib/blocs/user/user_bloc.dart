import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style/data/model/pet/pet.dart';
import 'package:pet_style/data/model/user/user.dart';
import 'package:pet_style/domain/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc(this.userRepository) : super(UserInitial()) {
    on<FetchUserData>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await userRepository.getUserData();
        final List<Pet> pets = user?.pets?.toList() ?? [];
        if (user != null) {
          emit(UserLoaded(user, pets));
        } else {
          emit(const UserError('Failed to load user data'));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

  }
}
