import 'package:flutter/material.dart';
import 'package:predictiva_flutter/widgets/summary/summary_cell.dart';
import 'package:predictiva_flutter/widgets/summary/summary_footer.dart';

enum Status { succes, warning, error }

class Summary extends StatelessWidget {
  final double balance;
  final double profits;
  final int profitPercentage;
  final int assets;
  final Status status;
  final String statusMessage;
  final bool loading;

  const Summary({
    super.key,
    required this.balance,
    required this.profits,
    required this.profitPercentage,
    required this.assets,
    required this.status,
    required this.statusMessage,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
          color: const Color(0xff161619),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(
            width: 1,
            color: const Color(0xff3E3F48),
          )),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Column(
          children: [
            SummaryCell(
              label: "Balance",
              value: balance,
              isLoading: loading,
              isPrice: true,
              showBorder: true,
            ),
            SummaryCell(
              label: "Profits",
              value: profits,
              isLoading: loading,
              isPrice: true,
              percentage: 30,
              showBorder: true,
            ),
            SummaryCell(
              label: "Assets",
              value: assets.toDouble(),
              isLoading: loading,
              isPrice: false,
            ),
            const SummaryFooter(
                status: Status.warning,
                message: "This subscription expires in a month")
          ],
        ),
      ),
    );
  }
}
