
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughtbox/bloc/weather_event.dart';
import 'package:thoughtbox/bloc/weather_state.dart';
import 'package:thoughtbox/repository/api.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        dynamic users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
