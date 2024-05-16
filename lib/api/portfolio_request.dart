import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:predictiva_flutter/utils/snackbar.dart';

class Portfolio {
  final double balance;
  final double profit;
  final int profitPercentage;
  final int assets;

  Portfolio({
    required this.balance,
    required this.profit,
    required this.profitPercentage,
    required this.assets,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    return Portfolio(
      balance: json['balance'],
      profit: json['profit'],
      profitPercentage: json['profit_percentage'],
      assets: json['assets'],
    );
  }
}

Future<Portfolio> fetchPortfolio() async {
  final response = await http.get(
    Uri.parse(
        'https://api-cryptiva.azure-api.net/staging/api/v1/accounts/portfolio'),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return Portfolio.fromJson(jsonResponse['data']['portfolio']);
  } else {
    showSnackbar("Failed to load portfolio");
    return Portfolio(balance: 0, profit: 0, profitPercentage: 0, assets: 0);
  }
}
