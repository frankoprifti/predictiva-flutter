import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:predictiva_flutter/widgets/tag.dart';
import 'package:shimmer/shimmer.dart';

final formatCurrency = NumberFormat.currency(locale: 'en_US', symbol: '\$');

class SummaryCell extends StatelessWidget {
  final String label;
  final double value;
  final double? percentage;
  final bool isLoading;
  final bool isPrice;
  final bool showBorder;

  const SummaryCell({
    super.key,
    required this.label,
    required this.value,
    this.percentage,
    required this.isLoading,
    required this.isPrice,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: showBorder ? 1 : 0, color: const Color(0xff3E3F48)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 16),
              ),
              isLoading
                  ? Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 69, 69, 69),
                      highlightColor: Colors.white,
                      child: Container(
                        height: 24,
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      children: [
                        Text(
                          isPrice
                              ? formatCurrency.format(value)
                              : value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        percentage != null
                            ? Tag(
                                value: percentage!.toInt(),
                              )
                            : Container()
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
