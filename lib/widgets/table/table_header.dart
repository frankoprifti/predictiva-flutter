import 'package:flutter/material.dart';
import 'package:predictiva_flutter/widgets/button.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Open trades',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          BorderIconButton(
            icon: Icons.filter_list,
          ),
        ],
      ),
    );
  }
}
