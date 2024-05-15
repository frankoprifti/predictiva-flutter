import 'package:flutter/material.dart';

class BorderIconButton extends StatefulWidget {
  final IconData icon;
  const BorderIconButton({Key? key, required this.icon}) : super(key: key);

  @override
  _BorderIconButtonState createState() => _BorderIconButtonState();
}

class _BorderIconButtonState extends State<BorderIconButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isSelected = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isSelected = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isSelected = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.linear,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.white : const Color(0xff3E3F48),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          widget.icon,
          color: Color(0xffEDEDF0),
          size: 24,
        ),
      ),
    );
  }
}
