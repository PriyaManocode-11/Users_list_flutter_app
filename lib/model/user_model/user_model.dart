import 'package:users_list/constants/constant_params.dart';
import 'package:users_list/model/user_model/user_list_model.dart';

class UserDetails {
  User? data;
  Support? support;

  UserDetails({this.data, this.support});

  UserDetails.fromJson(Map<String, dynamic> json) {
    data = json[ConstantParams.support] != null
        ? User.fromJson(json[ConstantParams.data])
        : null;
    support = json[ConstantParams.support] != null
        ? Support.fromJson(json[ConstantParams.support])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> userData = <String, dynamic>{};
    userData[ConstantParams.data] = data != null ? (data!.toJson()) : null;
    userData[ConstantParams.support] =
        support != null ? (support!.toJson()) : null;
    return userData;
  }
}

class User {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  User({this.id, this.email, this.firstName, this.lastName, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json[ConstantParams.id];
    email = json[ConstantParams.email];
    firstName = json[ConstantParams.firstName];
    lastName = json[ConstantParams.lastName];
    avatar = json[ConstantParams.avatar];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[ConstantParams.id] = id;
    data[ConstantParams.email] = email;
    data[ConstantParams.firstName] = firstName;
    data[ConstantParams.lastName] = lastName;
    data[ConstantParams.avatar] = avatar;
    return data;
  }
}
