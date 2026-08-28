import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:owner_app/view/screen/dashbored/dashbored.dart';
import 'package:owner_app/view/screen/order/order.dart';
import 'package:owner_app/view/screen/settings/settings.dart';
import 'package:owner_app/view/screen/store/store_page.dart';
import 'package:owner_app/view/widgets/home/custom_bottom_nav_bar.dart';


class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late int _currentIndex = widget.initialIndex;

  final List<Widget> bodies = [
    DashboardView(),
    StorePage(),
    const OrdersView(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: bodies,
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}