import 'package:flutter/material.dart';
import 'package:predictiva_flutter/widgets/table/table_header.dart';

class OrderTable extends StatefulWidget {
  const OrderTable({super.key});

  @override
  State<OrderTable> createState() => _OrderTableState();
}

class _OrderTableState extends State<OrderTable> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: const Color(0xff161619),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(
            width: 1,
            color: const Color(0xff3E3F48),
          )),
      child: const ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Column(
          children: [
            TableHeader(),
          ],
        ),
      ),
    );
  }
}
