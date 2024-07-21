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
import 'package:users_list/utitlity/styles.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage>
    with SingleTickerProviderStateMixin {
  UsersList? usersList;
  UsersBloc? usersBloc;
  List<Item> footerArr = [];
  int page = 1;
  bool kisweb = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    usersBloc = BlocProvider.of<UsersBloc>(context);
    fetchUserList();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 1);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void fetchUserList() {
    var body = {ConstantParams.page: page};
    usersBloc!
      ..queryParam = body
      ..add(UserEvents.usersList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User List",
          style: textStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
                  isClicked: index == page - 1,
                ),
              );
            }
          }
          return state is UsersLoadingState
              ? Center(
              child: Platform.isIOS
                  ? const CupertinoActivityIndicator()
                  : const CircularProgressIndicator())
              : Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: AnimatedBuilder(
                          animation: _animationController,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: (usersList?.data ?? []).length,
                            itemBuilder: (ctxt, index) {
                              return ListTile(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const UserDetailsPage(),
                                  ));
                                  usersBloc!
                                    ..userId = "${usersList?.data?[index].id}"
                                    ..add(UserEvents.updateState);
                                },
                                leading: Image.network(
                                  usersList?.data?[index].avatar ?? '',
                                ),
                                title: Text(
                                  '${usersList?.data?[index].firstName} ${usersList?.data?[index].lastName}',
                                  style: textStyle(),
                                ),
                                subtitle: Text(
                                  usersList?.data?[index].email ?? '',
                                  style: textStyle(
                                      fontSize: 12, textColor: Colors.grey),
                                ),
                              );
                            },
                          ),
                          builder: (conxt, child) {
                            return SlideTransition(
                                position: Tween(
                                        begin: const Offset(0, 0.3),
                                        end: const Offset(0, 0))
                                    .animate(CurvedAnimation(
                                        parent: _animationController,
                                        curve: Curves.bounceInOut)),
                                child: child);
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

  void stepperIndexUpdate(String type, int index) {
    int selectedIndex = footerArr.indexWhere((element) => element.isClicked);
    for (var element in footerArr) {
      element.isClicked = false;
    }

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

    int newPage = currentIndex + 1;
    if (page != newPage) {
      page = newPage;
      fetchUserList();
    }
    usersBloc!.add(UserEvents.updateState);
  }
}
