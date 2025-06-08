import 'package:bytecart/models/users/user_type.dart';
import 'package:bytecart/screens/account.dart';
import 'package:bytecart/screens/cart.dart';
import 'package:bytecart/screens/categories.dart';
import 'package:bytecart/screens/home.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  final User user;

  const BottomNav({super.key, required this.user});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  // Navigation icons and labels
  static const _icons = [
    Icons.home,
    Icons.shopping_bag,
    Icons.shopping_cart,
    Icons.person,
  ];
  static const _labels = ['Home', 'Categories', 'Cart', 'Account'];

  // Pages for each tab
  late final List<Widget> _pages = [
    HomePage(user: widget.user),
    const CategoryPage(),
    const CartPage(),
    AccountPage(user: widget.user),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final selectedColor = const Color(0xFF007BFF);
    final unselectedColor = isDark ? Colors.white : const Color(0xFF0D1117);

    // Navigation destinations
    final destinations = List.generate(
      _icons.length,
      (i) => NavigationDestination(
        icon: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Icon(_icons[i], color: unselectedColor),
        ),
        selectedIcon: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Icon(_icons[i], color: selectedColor),
        ),
        label: _labels[i],
      ),
    );

    // Main scaffold with navigation bar
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF121212) : theme.colorScheme.surface,
          boxShadow:
              !isDark
                  ? const [
                    BoxShadow(
                      color: Color.fromARGB(15, 0, 0, 0),
                      blurRadius: 4,
                      offset: Offset(0, -2),
                    ),
                  ]
                  : null,
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          selectedIndex: _selectedIndex,
          onDestinationSelected:
              (index) => setState(() => _selectedIndex = index),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: destinations,
        ),
      ),
    );
  }
}
