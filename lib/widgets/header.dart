import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String name;
  const Header({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Hi $name,",
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        const Text(
          "Here is an overview of your account activities.",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
