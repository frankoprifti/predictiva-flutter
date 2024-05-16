import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:predictiva_flutter/api/orders_request.dart';
import 'package:predictiva_flutter/api/portfolio_request.dart';
import 'package:predictiva_flutter/utils/filter.dart';
import 'package:predictiva_flutter/widgets/header.dart';
import 'package:predictiva_flutter/widgets/nav.dart';
import 'package:predictiva_flutter/widgets/summary/summary.dart';
import 'package:predictiva_flutter/widgets/table/order_table.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool portfolioLoading = true;
  bool ordersLoading = true;

  Portfolio portfolio =
      Portfolio(balance: 0, profit: 0, profitPercentage: 0, assets: 0);
  List<Order> orders = [];
  List<Order> unfilteredOrders = [];

  @override
  void initState() {
    loadPortfolio();
    loadOrders();
    super.initState();
  }

  void loadPortfolio() async {
    Portfolio data = await fetchPortfolio();
    setState(() {
      portfolio = data;
      portfolioLoading = false;
    });
  }

  void loadOrders() async {
    List<Order> data = await fetchOrders();
    setState(() {
      orders = data;
      unfilteredOrders = data;
      ordersLoading = false;
    });
  }

  void onFilter(
    String? symbol,
    int? price,
    DateTime? startDate,
    DateTime? endDate,
  ) {
    List<Order> filteredOrders =
        filterOrders(unfilteredOrders, symbol, price, startDate, endDate);
    setState(() {
      orders = filteredOrders;
    });
  }

  void clearFilters() {
    setState(() {
      orders = unfilteredOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Nav(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Column(
                  children: [
                    const Header(name: "Robin"),
                    const SizedBox(
                      height: 32,
                    ),
                    Summary(
                      loading: portfolioLoading,
                      balance: portfolio.balance,
                      profits: portfolio.profit,
                      profitPercentage: portfolio.profitPercentage,
                      assets: portfolio.assets,
                      status: Status.warning,
                      statusMessage: "This subscription expires in a month",
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    OrderTable(
                      isLoading: ordersLoading,
                      orders: orders,
                      onFilter: onFilter,
                      clearFilters: clearFilters,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
