import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_list/bloc/userBloc/user_bloc.dart';
import 'package:users_list/bloc/userBloc/user_events.dart';
import 'package:users_list/bloc/userBloc/user_state.dart';
import 'package:users_list/components/cupertino_avator_image.dart';
import 'package:users_list/model/user_model/user_model.dart';
import 'package:users_list/utitlity/styles.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  UsersBloc? usersBloc;
  UserDetails? userData;
  @override
  void initState() {
    usersBloc = BlocProvider.of<UsersBloc>(context);
    usersBloc!.add(UserEvents.userData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(
                "Profile",
                style: textStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            child: _buildUserDetails(),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Profile",
                style: textStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: _buildUserDetails(),
          );
  }

  BlocBuilder<UsersBloc, UsersState> _buildUserDetails() {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (BuildContext ctxt, UsersState state) {
        if (state is UserDataState) {
          userData = state.userData;
        }
        return userData == null
            ? Center(
                child: Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator())
            : SafeArea(
                child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Platform.isIOS
                          ? CupertinoAvatar(
                              radius: 50,
                              imageUrl: userData?.data?.avatar ?? '')
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(userData?.data?.avatar ?? ''),
                            ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        '${userData?.data?.firstName} ${userData?.data?.lastName}',
                        style: textStyle(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(userData?.data?.email ?? '',
                          style: textStyle(
                              fontSize: 12,
                              textColor: Platform.isIOS
                                  ? CupertinoColors.systemGrey
                                  : Colors.grey)),
                    ),
                  ],
                ),
              ));
      },
    );
  }
}
