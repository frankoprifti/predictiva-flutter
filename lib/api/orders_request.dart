import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:predictiva_flutter/utils/snackbar.dart';

class Order {
  final String symbol;
  final String type;
  final String side;
  final double quantity;
  final int creationTime;
  final double price;

  Order({
    required this.symbol,
    required this.type,
    required this.side,
    required this.quantity,
    required this.creationTime,
    required this.price,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      symbol: json['symbol'],
      type: json['type'],
      side: json['side'],
      quantity: json['quantity'].toDouble(),
      creationTime: json['creation_time'],
      price: json['price'].toDouble(),
    );
  }
}

Future<List<Order>> fetchOrders() async {
  final response = await http.get(
    Uri.parse('https://api-cryptiva.azure-api.net/staging/api/v1/orders/open'),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final List<dynamic> orderList = jsonResponse['data']['orders'];
    List<Order> orders = orderList.map((item) => Order.fromJson(item)).toList();
    return orders;
  } else {
    showSnackbar("Failed to load orders");
    return [];
  }
}
