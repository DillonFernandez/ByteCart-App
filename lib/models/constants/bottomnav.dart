import 'package:bytecart/models/users/user_type.dart';
import 'package:bytecart/screens/account.dart';
import 'package:bytecart/screens/cart.dart';
import 'package:bytecart/screens/categories.dart';
import 'package:bytecart/screens/home.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  final User user;

  const BottomNav({Key? key, required this.user}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Theme and color setup
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final selectedColor = const Color(0xFF007BFF);
    final unselectedColor = isDark ? Colors.white : const Color(0xFF0D1117);

    // Bottom navigation icons and labels
    const icons = [
      Icons.home,
      Icons.shopping_bag,
      Icons.shopping_cart,
      Icons.person,
    ];
    const labels = <String>['Home', 'Categories', 'Cart', 'Account'];

    // Build NavigationDestination list for NavigationBar
    final destinations = <NavigationDestination>[];
    for (var i = 0; i < icons.length; i++) {
      destinations.add(
        NavigationDestination(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Icon(icons[i], color: unselectedColor),
          ),
          selectedIcon: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Icon(icons[i], color: selectedColor),
          ),
          label: labels[i],
        ),
      );
    }

    // Pages for each navigation tab
    final List<Widget> pages = [
      HomePage(user: widget.user),
      const CategoryPage(),
      const CartPage(),
      AccountPage(user: widget.user),
    ];

    // Main scaffold with navigation bar
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          boxShadow:
              !isDark
                  ? const [
                    BoxShadow(
                      color: Color.fromARGB(10, 0, 0, 0),
                      blurRadius: 4,
                      offset: Offset(0, -2),
                    ),
                  ]
                  : null,
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: destinations,
        ),
      ),
    );
  }
}
