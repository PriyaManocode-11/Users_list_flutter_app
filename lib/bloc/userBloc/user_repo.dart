import 'package:users_list/model/user_model/user_list_model.dart';
import 'package:users_list/model/user_model/user_model.dart';
import 'package:users_list/services/api_client.dart';

abstract class UsersRepository {
  Future<UsersList> fetchUsersList(String url, dynamic queryParam);
  Future<UserDetails> fetchUserData(String url);
}

class UsersService extends UsersRepository {
  @override
  Future<UsersList> fetchUsersList(String url, queryParam) async{
    var json = await ApiClient().get(url, queryParam: queryParam);
    UsersList response = UsersList.fromJson(json);
    return response;
  }
  
  @override
  Future<UserDetails> fetchUserData(String url) async{
    var json = await ApiClient().get(url);
    UserDetails response = UserDetails.fromJson(json);
    return response;
  }
}