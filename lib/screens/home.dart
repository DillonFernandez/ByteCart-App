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
    final newStockProducts =
        productList.where((p) => p.newStock == true).toList();
    final onSaleProducts =
        productList.where((p) => (p.salePercentage ?? 0) > 0).toList();

    return Scaffold(
      appBar: app_bar.mainAppBar(context),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: [
            // Category Circles Section
            _CategoryCirclesRow(),
            const SizedBox(height: 16),
            // Top Banner Section
            _BannerSection(imagePath: 'assets/images/banner/Banner 1.webp'),
            // New Stock Products Grid Section
            _ProductGridSection(products: newStockProducts),
            // Middle Banner Section
            _BannerSection(
              imagePath: 'assets/images/banner/Banner 2.webp',
              topPadding: 30,
            ),
            // On Sale Products Grid Section
            _ProductGridSection(products: onSaleProducts),
          ],
        ),
      ),
    );
  }
}

// Category Circles Row
class _CategoryCirclesRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final categories = [
      _categoryCircle(
        context,
        Icons.phone_iphone,
        Colors.lightBlue,
        'Smartphones & Accessories',
      ),
      _categoryCircle(
        context,
        Icons.laptop,
        Colors.deepPurple,
        'Computers & Laptops',
      ),
      _categoryCircle(
        context,
        Icons.headset,
        Colors.deepOrange,
        'Audio & Headphones',
      ),
      _categoryCircle(
        context,
        Icons.videogame_asset,
        Colors.redAccent,
        'Gaming & Entertainment',
      ),
      _categoryCircle(
        context,
        Icons.camera_alt,
        Colors.indigo,
        'Cameras & Photography',
      ),
      _categoryCircle(
        context,
        Icons.security,
        Colors.blueGrey,
        'Smart Home & Security',
      ),
      _categoryCircle(context, Icons.kitchen, Colors.teal, 'Home Appliances'),
      _categoryCircle(context, Icons.watch, Colors.pinkAccent, 'Wearable Tech'),
    ];
    return isLandscape
        ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: categories,
        )
        : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: categories,
          ),
        );
  }

  // Single Category Circle
  static Widget _categoryCircle(
    BuildContext context,
    IconData icon,
    Color color,
    String title,
  ) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProductPage(title: title)),
          ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
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

// Banner Section
class _BannerSection extends StatelessWidget {
  final String imagePath;
  final double topPadding;

  const _BannerSection({required this.imagePath, this.topPadding = 0});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: AspectRatio(
        aspectRatio: isLandscape ? 4.5 : 2.5,
        child: BannerWidget(imagePath: imagePath),
      ),
    );
  }
}

// Product Grid Section
class _ProductGridSection extends StatelessWidget {
  final List products;

  const _ProductGridSection({required this.products});

  @override
  Widget build(BuildContext context) {
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
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
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
  }
}
