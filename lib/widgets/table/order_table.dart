import 'package:flutter/material.dart';
import 'package:predictiva_flutter/api/orders_request.dart';
import 'package:predictiva_flutter/widgets/table/table_footer.dart';
import 'package:predictiva_flutter/widgets/table/table_header.dart';
import 'package:predictiva_flutter/widgets/table/table_row.dart';

class OrderTable extends StatefulWidget {
  final List<Order> orders;
  final bool isLoading;

  const OrderTable({super.key, required this.orders, required this.isLoading});

  @override
  State<OrderTable> createState() => _OrderTableState();
}

class _OrderTableState extends State<OrderTable> {
  int currentPage = 1;
  final int itemsPerPage = 5;
  late String filterSymbol;
  late int filterPrice;
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();
  }

  void updateCurrent(int page) {
    setState(() {
      currentPage = page;
    });
  }

  Future<void> _selectDate(BuildContext context,
      {required bool isStartDate}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      // Handle selected date
      print('Selected date: $pickedDate');
    }
  }

  void showFilterModal(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: const Color(0xff19191B),
          content: Container(
            width: width,
            height: height / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    hintText: 'Symbol',
                    hintStyle: const TextStyle(color: Color(0xff9E9EA5)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Color(0xff3E3F48)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Color(0xff3E3F48)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Color(0xff3E3F48)),
                    ),
                  ),
                  value: null,
                  onChanged: (String? newValue) {
                    // Handle dropdown value change
                  },
                  items: widget.orders
                      .map((order) => order.symbol)
                      .toSet() // Convert to set to remove duplicates
                      .map<DropdownMenuItem<String>>((symbol) {
                    return DropdownMenuItem<String>(
                      value: symbol,
                      child: Text(symbol),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    hintText: 'Price',
                    hintStyle: const TextStyle(color: Color(0xff9E9EA5)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Color(0xff3E3F48)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Color(0xff3E3F48)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Color(0xff3E3F48)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    // Handle price input change
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Date range",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    _selectDate(context, isStartDate: true);
                  },
                  child: Row(
                    children: [
                      Text('Select Start Date'),
                      SizedBox(width: 5),
                      Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Column(
          children: [
            TableHeader(
              showModal: () {
                showFilterModal(context);
              },
            ),
            for (var i = (currentPage - 1) * 5;
                i < (currentPage - 1) * 5 + itemsPerPage &&
                    i < widget.orders.length;
                i++)
              OrderTableRow(
                action: "Sell",
                symbol: widget.orders[i].symbol,
                price: widget.orders[i].price,
                type: widget.orders[i].type,
                quantity: widget.orders[i].quantity,
                date: widget.orders[i].creationTime,
              ),
            OrderTableFooter(
              currentPage: currentPage,
              totalItems: widget.orders.length,
              itemsPerPage: itemsPerPage,
              updateCurrentPage: updateCurrent,
            )
          ],
        ),
      ),
    );
  }
}
