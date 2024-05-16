import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextBadge extends StatelessWidget {
  final String text;
  final Color color;

  const TextBadge({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          color: const Color(0xff212126),
          border: Border.all(width: 1, color: color),
          borderRadius: const BorderRadius.all(Radius.circular(60))),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 14,
        ),
      ),
    );
  }
}
