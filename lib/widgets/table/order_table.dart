import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:predictiva_flutter/api/orders_request.dart';
import 'package:predictiva_flutter/widgets/table/table_footer.dart';
import 'package:predictiva_flutter/widgets/table/table_header.dart';
import 'package:predictiva_flutter/widgets/table/table_row.dart';

typedef FilterCallback = void Function(
  String? symbol,
  int? price,
  DateTime? startDate,
  DateTime? endDate,
);

class OrderTable extends StatefulWidget {
  final List<Order> orders;
  final bool isLoading;
  final FilterCallback onFilter;
  final VoidCallback clearFilters;

  const OrderTable({
    super.key,
    required this.orders,
    required this.isLoading,
    required this.onFilter,
    required this.clearFilters,
  });

  @override
  State<OrderTable> createState() => _OrderTableState();
}

class _OrderTableState extends State<OrderTable> {
  int currentPage = 1;
  final int itemsPerPage = 5;
  String? filterSymbol;
  int? filterPrice;
  DateTime? startDate;
  DateTime? endDate;
  bool isFiltered = false;

  @override
  void initState() {
    super.initState();
  }

  void updateCurrent(int page) {
    setState(() {
      currentPage = page;
    });
  }

  void showFilterModal(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          Future<void> selectDate(BuildContext context,
              {required bool isStartDate}) async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: !isStartDate && startDate != null
                  ? startDate!
                  : DateTime(2015, 8),
              lastDate:
                  isStartDate && endDate != null ? endDate! : DateTime(2101),
            );
            if (pickedDate != null) {
              setState(() {
                if (isStartDate) {
                  startDate = pickedDate;
                } else {
                  endDate = pickedDate;
                }
              });
            }
          }

          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            backgroundColor: const Color(0xff19191B),
            content: Container(
              width: width,
              height: height / 2.7,
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
                    value: filterSymbol,
                    onChanged: (String? newValue) {
                      setState(() {
                        filterSymbol = newValue;
                      });
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
                      setState(() {
                        filterPrice = int.tryParse(value);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Date range",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(color: Color(0xff3E3F48)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () {
                      selectDate(context, isStartDate: true);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          startDate != null
                              ? DateFormat('d MMM, yyyy').format(startDate!)
                              : 'Start date',
                          style: TextStyle(
                              color: startDate != null
                                  ? Colors.white
                                  : const Color(0xff9E9EA5)),
                        ),
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(color: Color(0xff3E3F48)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () {
                      selectDate(context, isStartDate: false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          endDate != null
                              ? DateFormat('d MMM, yyyy').format(endDate!)
                              : 'End date',
                          style: TextStyle(
                              color: endDate != null
                                  ? Colors.white
                                  : const Color(0xff9E9EA5)),
                        ),
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      isFiltered
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 12),
                                shadowColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                side:
                                    const BorderSide(color: Color(0xff3E3F48)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  isFiltered = false;
                                  filterSymbol = null;
                                  filterPrice = null;
                                  startDate = null;
                                  endDate = null;
                                });
                                widget.clearFilters();
                                Navigator.of(context).pop();
                              },
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Clear filter',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          shadowColor: Colors.transparent,
                          backgroundColor: const Color(0xff00BCAF),
                          side: const BorderSide(color: Color(0xff3E3F48)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isFiltered = true;
                          });
                          widget.onFilter(
                              filterSymbol, filterPrice, startDate, endDate);
                          Navigator.of(context).pop();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Filter table',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
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
