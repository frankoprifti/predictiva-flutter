import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Tag extends StatelessWidget {
  final int value;

  const Tag({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    Color color = value < 0 ? const Color(0xffE40C0C) : const Color(0xff00AC3A);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: color),
          borderRadius: const BorderRadius.all(Radius.circular(60))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.flip(
            flipX: value < 0,
            flipY: value < 0,
            child: Icon(
              Icons.arrow_outward,
              color: color,
              size: 20,
            ),
          ),
          Text(
            '${value.abs()}%',
            style: TextStyle(
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
