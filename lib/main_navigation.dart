import 'package:flutter/material.dart';
import 'shopkeeper_dashboard.dart';
import 'products_page.dart';
import 'orders_page.dart';
import 'account_page.dart';
import 'home_page.dart';
import 'customer_products_page.dart';
import 'orders_list_page.dart';
import 'customer_cart_page.dart';
import 'customer_orders_page.dart';
import 'manager/manager_dashboard.dart';
import 'manager/manager_shops_page.dart';
import 'manager/manager_orders_page.dart';
import 'manager/manager_revenue_page.dart';
import 'manager/manager_users_page.dart';
import 'widgets/custom_bottom_nav.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;
  final String role;
  const MainNavigationScreen({super.key, this.initialIndex = 0, this.role = 'shopkeeper'});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _selectedIndex;

  List<Widget> get _pages {
    if (widget.role == 'customer') {
      return [
        const CustomerHomePage(),
        const CustomerProductsPage(),
        const CustomerCartPage(),
        const CustomerOrdersPage(),
        AccountPage(role: widget.role),
      ];
    }
    if (widget.role == 'manager') {
      return [
        ManagerDashboard(onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        }),
        const ManagerShopsPage(),
        const ManagerOrdersPage(),
        const ManagerRevenuePage(),
        const ManagerUsersPage(),
      ];
    }
    return [
      const ShopkeeperDashboard(),
      const ProductsPage(),
      const OrdersPage(),
      AccountPage(role: widget.role),
    ];
  }

  List<String> get _labels {
    if (widget.role == 'customer') {
      return ['HOME', 'PRODUCTS', 'ORDERS', 'MY ORDERS', 'ACCOUNT'];
    }
    if (widget.role == 'manager') {
      return ['DASHBOARD', 'SHOPS', 'ORDERS', 'REVENUE', 'USERS'];
    }
    return ['DASHBOARD', 'PRODUCTS', 'ORDERS', 'ACCOUNT'];
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(String label) {
    int index = _labels.indexOf(label);
    if (index != -1) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        activeLabel: _labels[_selectedIndex],
        onTap: _onItemTapped,
        role: widget.role,
      ),
    );
  }
}
