import 'package:users_list/constants/constant_params.dart';
import 'package:users_list/model/user_model/user_model.dart';

class UsersList {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<User>? data;
  Support? support;

  UsersList(
      {this.page,
      this.perPage,
      this.total,
      this.totalPages,
      this.data,
      this.support});

  UsersList.fromJson(Map<String, dynamic> json) {
    page = json[ConstantParams.page];
    perPage = json[ConstantParams.perPage];
    total = json[ConstantParams.total] ?? "";
    totalPages = json[ConstantParams.totalPages];
    data = json[ConstantParams.data] == null
        ? null
        : (json[ConstantParams.data] as List)
            .map((e) => User.fromJson(e))
            .toList();
    support = json[ConstantParams.support] != null
        ? Support.fromJson(json[ConstantParams.support])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> userdata = <String, dynamic>{};
    userdata[ConstantParams.page] = page;
    userdata[ConstantParams.perPage] = perPage;
    userdata[ConstantParams.total] = total;
    userdata[ConstantParams.totalPages] = totalPages;
    userdata[ConstantParams.data] =
        data != null ? data!.map((v) => v.toJson()).toList() : [];
    userdata[ConstantParams.support] =
        support != null ? (support!.toJson()) : null;
    return userdata;
  }
}

class Support {
  String? url;
  String? text;

  Support({this.url, this.text});

  Support.fromJson(Map<String, dynamic> json) {
    url = json[ConstantParams.url];
    text = json[ConstantParams.text];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[ConstantParams.url] = url;
    data[ConstantParams.text] = text;
    return data;
  }
}
