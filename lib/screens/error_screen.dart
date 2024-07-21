import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Some Error Occured",
          style: TextStyle(
              color: Colors.red, fontSize: 30, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
