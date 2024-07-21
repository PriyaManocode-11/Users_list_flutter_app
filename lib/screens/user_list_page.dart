import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:users_list/bloc/userBloc/user_bloc.dart';
import 'package:users_list/bloc/userBloc/user_events.dart';
import 'package:users_list/bloc/userBloc/user_state.dart';
import 'package:users_list/components/bottom_pagination_widget.dart';
import 'package:users_list/constants/constant_params.dart';
import 'package:users_list/constants/strings.dart';
import 'package:users_list/model/user_model/item_model.dart';
import 'package:users_list/model/user_model/user_list_model.dart';
import 'package:users_list/screens/user_details_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  UsersList? usersList;
  UsersBloc? usersBloc;
  List<Item> footerArr = [];
  int page = 1;
  bool kisweb = false;


  @override
  void initState() {
    usersBloc = BlocProvider.of<UsersBloc>(context);
    fetchUserList();
    super.initState();
  }

  fetchUserList() {
    var body = {ConstantParams.page: page};
    usersBloc!
      ..queryParam = body
      ..add(UserEvents.usersList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
        centerTitle: true,
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (BuildContext context, UsersState state) {
          if (state is UsersListState) {
            usersList = state.usersListState;
            page = state.usersListState.page!;
            if (page != 0) {
              int totalPage = state.usersListState.totalPages ?? 0;
              footerArr = List<Item>.generate(
                  totalPage,
                  (index) => Item(
                      id: index + 1,
                      name: "${index + 1}",
                      isClicked: index == 0));
            }
          }
          return state is UsersLoadingState
              ? const Center(
                  child: CircularProgressIndicator())
              : Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: (usersList?.data ?? []).length,
                          itemBuilder: (ctxt, index) {
                            return Hero(
                              tag: "hai",
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const UserDetailsPage(),
                                  ));
                                  usersBloc!
                                    ..userId = "${usersList?.data?[index].id}"
                                    ..add(UserEvents.updateState);
                                },
                                leading: Image.network(
                                    usersList?.data?[index].avatar ?? ''),
                                title: Text(
                                    '${usersList?.data?[index].firstName} ${usersList?.data?[index].lastName}'),
                                subtitle:
                                    Text(usersList?.data?[index].email ?? ''),
                              ),
                            );
                          },
                        ),
                      ),
                      BottomPaginationWidget(
                        footerArr,
                        stepperIndexClick: (item) {
                          stepperIndexUpdate(item.name, item.id);
                        },
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }

  stepperIndexUpdate(String type, int index) {
    int selectedIndex = footerArr.indexWhere((element) => element.isClicked);
    footerArr.asMap().forEach((key, value) {
      footerArr[key].isClicked = false;
    });

    int currentIndex = 0;
    if (type == Strings.left) {
      currentIndex = selectedIndex == 0 ? 0 : selectedIndex - 1;
    } else if (type == Strings.right) {
      currentIndex = selectedIndex == footerArr.length - 1
          ? footerArr.length - 1
          : selectedIndex + 1;
    } else {
      currentIndex = index;
    }
    footerArr[currentIndex].isClicked = true;
    if (page != (currentIndex)) {
      page = currentIndex;
    }
    usersBloc!.add(UserEvents.updateState);
  }

  isWeb() {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        kisweb = false;
      } else {
        kisweb = true;
      }
    } catch (e) {
      kisweb = true;
    }
  }
}
