import 'package:bytecart/models/constants/appbar.dart';
import 'package:bytecart/models/constants/banner.dart';
import 'package:bytecart/models/constants/productcard.dart';
import 'package:bytecart/models/products/product_list.dart';
import 'package:bytecart/models/users/user_type.dart';
import 'package:bytecart/screens/products.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Filter products for "New Stock" and "On Sale" sections
    final newStockProducts =
        productList.where((p) => p.newStock == true).toList();
    final onSaleProducts =
        productList.where((p) => (p.salePercentage ?? 0) > 0).toList();

    return Scaffold(
      appBar: app_bar.mainAppBar(context),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          children: [
            // Category Circles Section
            LayoutBuilder(
              builder: (context, constraints) {
                final isLandscape =
                    MediaQuery.of(context).orientation == Orientation.landscape;
                final categories = [
                  categoryCircles(
                    context,
                    Icons.phone_iphone,
                    Colors.lightBlue,
                    'Smartphones & Accessories',
                  ),
                  categoryCircles(
                    context,
                    Icons.laptop,
                    Colors.deepPurple,
                    'Computers & Laptops',
                  ),
                  categoryCircles(
                    context,
                    Icons.headset,
                    Colors.deepOrange,
                    'Audio & Headphones',
                  ),
                  categoryCircles(
                    context,
                    Icons.videogame_asset,
                    Colors.redAccent,
                    'Gaming & Entertainment',
                  ),
                  categoryCircles(
                    context,
                    Icons.camera_alt,
                    Colors.indigo,
                    'Cameras & Photography',
                  ),
                  categoryCircles(
                    context,
                    Icons.security,
                    Colors.blueGrey,
                    'Smart Home & Security',
                  ),
                  categoryCircles(
                    context,
                    Icons.kitchen,
                    Colors.teal,
                    'Home Appliances',
                  ),
                  categoryCircles(
                    context,
                    Icons.watch,
                    Colors.pinkAccent,
                    'Wearable Tech',
                  ),
                ];
                if (isLandscape) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: categories,
                  );
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: categories,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            // Top Banner Section
            LayoutBuilder(
              builder: (context, constraints) {
                final isLandscape =
                    MediaQuery.of(context).orientation == Orientation.landscape;
                return AspectRatio(
                  aspectRatio: isLandscape ? 4.5 : 2.5,
                  child: const BannerWidget(
                    imagePath: 'assets/images/banner/Banner 1.webp',
                  ),
                );
              },
            ),
            // New Stock Products Grid Section
            LayoutBuilder(
              builder: (context, constraints) {
                final isLandscape =
                    MediaQuery.of(context).orientation == Orientation.landscape;
                final crossAxisCount = isLandscape ? 4 : 2;
                final aspectRatio = isLandscape ? 0.85 : 0.75;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: aspectRatio,
                  ),
                  itemCount: newStockProducts.length,
                  itemBuilder: (context, index) {
                    final product = newStockProducts[index];
                    return ProductCard(
                      newStock: product.newStock,
                      imagePath: product.imagePath,
                      productName: product.productName,
                      price: product.price,
                      isInStock: product.isInStock,
                      availableStock: product.availableStock,
                      salePercentage: product.salePercentage,
                    );
                  },
                );
              },
            ),
            // Middle Banner Section
            LayoutBuilder(
              builder: (context, constraints) {
                final isLandscape =
                    MediaQuery.of(context).orientation == Orientation.landscape;
                return Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: AspectRatio(
                    aspectRatio: isLandscape ? 4.5 : 2.5,
                    child: const BannerWidget(
                      imagePath: 'assets/images/banner/Banner 2.webp',
                    ),
                  ),
                );
              },
            ),
            // On Sale Products Grid Section
            LayoutBuilder(
              builder: (context, constraints) {
                final isLandscape =
                    MediaQuery.of(context).orientation == Orientation.landscape;
                final crossAxisCount = isLandscape ? 4 : 2;
                final aspectRatio = isLandscape ? 0.85 : 0.75;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: aspectRatio,
                  ),
                  itemCount: onSaleProducts.length,
                  itemBuilder: (context, index) {
                    final product = onSaleProducts[index];
                    return ProductCard(
                      newStock: product.newStock,
                      imagePath: product.imagePath,
                      productName: product.productName,
                      price: product.price,
                      isInStock: product.isInStock,
                      availableStock: product.availableStock,
                      salePercentage: product.salePercentage,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget for displaying a single category circle with icon and title
  Widget categoryCircles(
    BuildContext context,
    IconData icon,
    Color color,
    String title,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductPage(title: title)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [color.withOpacity(0.3), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: CircleAvatar(
          radius: 35,
          backgroundColor: Colors.transparent,
          child: Icon(icon, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
