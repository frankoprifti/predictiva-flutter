import 'package:flutter/material.dart';

class BorderIconButton extends StatefulWidget {
  final Widget icon;
  bool disabled = false;
  final VoidCallback onTap;

  BorderIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.disabled = false,
  }) : super(key: key);

  @override
  _BorderIconButtonState createState() => _BorderIconButtonState();
}

class _BorderIconButtonState extends State<BorderIconButton> {
  bool isSelected = false;
  void animationTrigger() async {
    setState(() {
      isSelected = true;
    });
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      isSelected = false;
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (widget.disabled) {
          return;
        }
        setState(() {
          isSelected = true;
        });
      },
      onTapUp: (_) {
        if (widget.disabled) {
          return;
        }
        setState(() {
          isSelected = false;
        });
      },
      onTapCancel: () {
        if (widget.disabled) {
          return;
        }
        setState(() {
          isSelected = false;
        });
      },
      onTap: () {
        if (widget.disabled) {
          return;
        }
        animationTrigger();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.white : const Color(0xff3E3F48),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Opacity(opacity: widget.disabled ? 0.5 : 1, child: widget.icon),
      ),
    );
  }
}
