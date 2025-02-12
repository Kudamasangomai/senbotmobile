import 'package:flutter/material.dart';

class SpaceBetween extends StatelessWidget {
  const SpaceBetween({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.black,
      thickness: 1.0,
      indent: 1.0,
      endIndent: 1.0,
    );
  }
}
