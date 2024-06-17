import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      if (user != null) {
        emit(UserLoaded(user));
      } else {
        emit(const UserError('Failed to load user data'));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  });


    
    
    // @override
    // Stream<UserState> mapEventToState(UserEvent event) async* {
    //   if (event is FetchUserData) {
    //     yield UserLoading();
    //     try {
    //       final user = await userRepository.getUserData();
    //       if (user != null) {
    //         yield UserLoaded(user);
    //       } else {
    //         yield const UserError('Failed to load user data');
    //       }
    //     } catch (e) {
    //       yield UserError(e.toString());
    //     }
    //   }
    // }
  }
}
