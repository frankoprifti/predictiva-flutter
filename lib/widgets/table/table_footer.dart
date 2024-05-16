import 'dart:math';

import 'package:flutter/material.dart';
import 'package:predictiva_flutter/widgets/button.dart';

class OrderTableFooter extends StatelessWidget {
  final int currentPage;
  final int totalItems;
  final int itemsPerPage;
  final void Function(int) updateCurrentPage;

  const OrderTableFooter({
    super.key,
    required this.currentPage,
    required this.totalItems,
    required this.itemsPerPage,
    required this.updateCurrentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 26),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: Color(0xff3E3F48)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              "${((currentPage - 1) * 5 + 1).toString()} - ${min(totalItems, ((currentPage - 1) * 5 + itemsPerPage)).toString()} of $totalItems"),
          Row(
            children: [
              BorderIconButton(
                disabled: currentPage <= 1,
                onTap: () {
                  updateCurrentPage(currentPage - 1);
                },
                icon: const Icon(
                  Icons.chevron_left,
                  color: Color(0xffEDEDF0),
                  size: 20,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              BorderIconButton(
                disabled: currentPage >= totalItems / itemsPerPage,
                onTap: () {
                  updateCurrentPage(currentPage + 1);
                },
                icon: const Icon(Icons.chevron_right,
                    color: Color(0xffEDEDF0), size: 20),
              ),
            ],
          )
        ],
      ),
    );
  }
}
