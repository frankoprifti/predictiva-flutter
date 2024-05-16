import 'package:predictiva_flutter/api/orders_request.dart';

List<Order> filterOrders(
  List<Order> orders,
  String? symbol,
  int? price,
  DateTime? startDate,
  DateTime? endDate,
) {
  List<Order> filteredOrders = orders;
  if (symbol != null) {
    filteredOrders =
        filteredOrders.where((order) => order.symbol == symbol).toList();
  }
  if (price != null) {
    filteredOrders =
        filteredOrders.where((order) => order.price <= price).toList();
  }
  if (startDate != null) {
    filteredOrders = filteredOrders
        .where((order) =>
            DateTime.fromMillisecondsSinceEpoch(order.creationTime * 1000)
                .isAfter(startDate))
        .toList();
  }
  if (endDate != null) {
    filteredOrders = filteredOrders
        .where((order) =>
            DateTime.fromMillisecondsSinceEpoch(order.creationTime * 1000)
                .isBefore(endDate))
        .toList();
  }
  return filteredOrders;
}
