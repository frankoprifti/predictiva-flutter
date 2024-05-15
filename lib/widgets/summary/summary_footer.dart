import 'package:flutter/material.dart';
import 'package:predictiva_flutter/widgets/summary/summary.dart';

class SummaryFooter extends StatelessWidget {
  final Status status;
  final String message;
  const SummaryFooter({super.key, required this.status, required this.message});

  Color _getColor(Status status) {
    switch (status) {
      case Status.warning:
        return const Color(0xffE7B500);
      case Status.error:
        return const Color(0xffE40C0C);
      default:
        return const Color(0xff00AC3A);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: Color(0xff111115),
        border: Border(
          top: BorderSide(width: 1, color: Color(0xff3E3F48)),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            size: 20,
            color: _getColor(status),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
