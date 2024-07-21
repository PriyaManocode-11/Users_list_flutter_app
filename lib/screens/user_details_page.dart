import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_list/bloc/userBloc/user_bloc.dart';
import 'package:users_list/bloc/userBloc/user_events.dart';
import 'package:users_list/bloc/userBloc/user_state.dart';
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
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (BuildContext ctxt, UsersState state) {
          if (state is UserDataState) {
            userData = state.userData;
          }
          return 
          // state is UsersLoadingState
          //     ? const Center(child: CircularProgressIndicator())
          //     : 
              SafeArea(
                  child: Hero(
                    tag: "hai",
                    child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(userData?.data?.avatar ?? ''),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            '${userData?.data?.firstName} ${userData?.data?.lastName}',
                            style: textStyle(),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            userData?.data?.email ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                                    ),
                  ));
        },
      ),
    );
  }
}
