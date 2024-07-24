import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_list/bloc/userBloc/user_bloc.dart';
import 'package:users_list/bloc/userBloc/user_repo.dart';
import 'package:users_list/screens/user_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UsersBloc(usersRepository: UsersService()),
          )
        ],
        child: Platform.isIOS
            ? const CupertinoApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: CupertinoThemeData(
                    barBackgroundColor: CupertinoColors.black,
                    brightness: Brightness.dark,
                    primaryColor: CupertinoDynamicColor(
                        color: CupertinoColors.systemRed,
                        darkColor: CupertinoColors.activeGreen,
                        highContrastColor: CupertinoColors.systemRed,
                        darkHighContrastColor: CupertinoColors.activeGreen,
                        elevatedColor: CupertinoColors.systemRed,
                        darkElevatedColor: CupertinoColors.activeGreen,
                        highContrastElevatedColor: CupertinoColors.systemRed,
                        darkHighContrastElevatedColor:
                            CupertinoColors.activeGreen)),
                home: UserListPage(),
              )
            : MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: const UserListPage()));
  }
}
