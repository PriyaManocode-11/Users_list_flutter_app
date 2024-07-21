import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_list/bloc/userBloc/user_events.dart';
import 'package:users_list/bloc/userBloc/user_repo.dart';
import 'package:users_list/bloc/userBloc/user_state.dart';
import 'package:users_list/constants/end_points.dart';

class UsersBloc extends Bloc<UserEvents, UsersState> {
  final UsersRepository usersRepository;
  String? userId;
  dynamic queryParam;

  UsersBloc({required this.usersRepository}) : super(UsersInitState()) {
    on<UserEvents>((events, emit) async{
      if(events == UserEvents.updateState) {
        emit(UsersUpdateState());       
        emit(UsersErrorState());
      } else if (events == UserEvents.usersList) {
        await fetchUserList(emit);
      } else if (events == UserEvents.userData) {
        await fetchUserData(emit);
      }
    }); 
  }

  fetchUserList(Emitter<UsersState> emit) async{
    try {
      emit(UsersLoadingState());
      var response = await usersRepository.fetchUsersList(EndPointsUrl.usersList, queryParam);
      emit(UsersLoadedState());
      emit(UsersListState(usersListState: response));
      return;
    } catch (e) {
      _catchError(e, emit);
    }
  }

  fetchUserData(Emitter<UsersState> emit) async{
    try {
      emit(UsersLoadingState());
      String endPoint = "${EndPointsUrl.usersList}/$userId";
      var response = await usersRepository.fetchUserData(endPoint);
      emit(UsersLoadedState());
      emit(UserDataState(userData: response));
      return;
    } catch (e) {
      _catchError(e, emit);
    }
  }

  _catchError(dynamic e, Emitter<UsersState> emit){
     emit(UsersLoadedState());
     emit(UsersError(error: e.toString()));
   }
}