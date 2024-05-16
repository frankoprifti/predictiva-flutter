import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:predictiva_flutter/widgets/badge.dart';

class OrderTableRow extends StatelessWidget {
  final String action;
  final String symbol;
  final double price;
  final String type;
  final double quantity;
  final int date;

  const OrderTableRow({
    super.key,
    required this.action,
    required this.symbol,
    required this.price,
    required this.type,
    required this.quantity,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date * 1000);

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: Color(0xff3E3F48)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          right: 16.0,
          top: 16,
          bottom: 16,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  symbol,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Text(
                  price.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextBadge(text: 'Sell', color: Color(0xffE40C0C)),
                Text(
                  DateFormat('d MMM, yyyy').format(dateTime),
                  style:
                      const TextStyle(fontSize: 16, color: Color(0xffB1B1B8)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
