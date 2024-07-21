import 'package:equatable/equatable.dart';
import 'package:users_list/model/user_model/item_model.dart';
import 'package:users_list/model/user_model/user_list_model.dart';
import 'package:users_list/model/user_model/user_model.dart';

abstract class UsersState extends Equatable {
  @override
  List<Object> get props => [];
}

class UsersInitState extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersLoadedState extends UsersState {}

class UsersUpdateState extends UsersState {}

class UsersErrorState extends UsersState {}

class UsersError extends UsersState {
  final String error;
  UsersError({required this.error});
}

class UsersListState extends UsersState {
  final UsersList usersListState;
  UsersListState({required this.usersListState});
}

class UserDataState extends UsersState {
  final UserDetails userData;
  UserDataState({required this.userData});
}

class FetchItems extends UsersState {
  final int page;
  final int pageSize;

  FetchItems(this.page, this.pageSize);
}

class ItemLoaded extends UsersState {
  final List<Item> items;
  final int currentPage;
  final int totalPages;

  ItemLoaded(this.items, this.currentPage, this.totalPages);
}
