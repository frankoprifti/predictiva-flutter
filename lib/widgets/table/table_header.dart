import 'package:flutter/material.dart';
import 'package:predictiva_flutter/widgets/button.dart';

class TableHeader extends StatelessWidget {
  final VoidCallback showModal;

  const TableHeader({super.key, required this.showModal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Open trades',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          BorderIconButton(
            onTap: () {
              showModal();
            },
            icon: const Icon(Icons.filter_list,
                color: Color(0xffEDEDF0), size: 24),
          ),
        ],
      ),
    );
  }
}
