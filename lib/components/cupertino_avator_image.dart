import 'package:flutter/material.dart';

class CupertinoAvatar extends StatelessWidget {
  final double radius;
  final String? imageUrl;

  const CupertinoAvatar({super.key, required this.radius, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageUrl ?? ''),
        ),
      ),
    );
  }
}