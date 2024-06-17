import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style/data/model/user/user.dart';
import 'package:pet_style/domain/repository/auth_repository.dart';
import 'package:pet_style/view/widget/toast.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;
  SignUpBloc(this.authRepository) : super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        //AuthResponse authResponse = await authRepository.login(event.user, event.password);
        //await _authRepository.setUserData(user);

        emit(SignUpSuccess());
      } catch (e) {
        log(e.toString());
        emit(SignUpFailure());
        toastInfo(msg: 'Login failed: $e');
      }
    });
  }
}
