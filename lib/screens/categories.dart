import 'package:bytecart/models/constants/appbar.dart';
import 'package:bytecart/screens/products.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of categories with icon, title, and color
    final categories = [
      {
        'icon': Icons.phone_iphone,
        'title': 'Smartphones & Accessories',
        'color': Colors.lightBlue,
      },
      {
        'icon': Icons.laptop,
        'title': 'Computers & Laptops',
        'color': Colors.deepPurple,
      },
      {
        'icon': Icons.headset,
        'title': 'Audio & Headphones',
        'color': Colors.deepOrange,
      },
      {
        'icon': Icons.videogame_asset,
        'title': 'Gaming & Entertainment',
        'color': Colors.redAccent,
      },
      {
        'icon': Icons.camera_alt,
        'title': 'Cameras & Photography',
        'color': Colors.indigo,
      },
      {
        'icon': Icons.security,
        'title': 'Smart Home & Security',
        'color': Colors.blueGrey,
      },
      {'icon': Icons.kitchen, 'title': 'Home Appliances', 'color': Colors.teal},
      {
        'icon': Icons.watch,
        'title': 'Wearable Tech',
        'color': Colors.pinkAccent,
      },
    ];

    return Scaffold(
      appBar: app_bar.mainAppBar(context),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.all(16.0),
        // Grid of category tiles
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.17,
          children:
              categories.map((cat) {
                return categoryTile(
                  icon: cat['icon'] as IconData,
                  title: cat['title'] as String,
                  color: cat['color'] as Color,
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => ProductPage(title: cat['title'] as String),
                        ),
                      ),
                );
              }).toList(),
        ),
      ),
    );
  }

  // Widget for a single category tile
  Widget categoryTile({
    required IconData icon,
    required String title,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF121212) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Category icon
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: color.withOpacity(0.15),
                        child: Icon(icon, color: color, size: 30),
                      ),
                      const SizedBox(height: 12),
                      // Category title
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
