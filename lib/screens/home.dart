import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:predictiva_flutter/api/portfolio_request.dart';
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
  @override
  void initState() {
    loadPortfolio();
    super.initState();
  }

  void loadPortfolio() async {
    Portfolio data = await fetchPortfolio();
    setState(() {
      portfolio = data;
      portfolioLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            const Nav(),
            SingleChildScrollView(
              child: Padding(
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
                    OrderTable(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
