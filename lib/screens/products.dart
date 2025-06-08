import 'package:bytecart/models/constants/productcard.dart';
import 'package:bytecart/models/products/product_list.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String title;

  const ProductPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: colorScheme.surface,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color:
                theme.brightness == Brightness.dark
                    ? const Color(0xFF121212)
                    : colorScheme.surface,
            boxShadow:
                theme.brightness == Brightness.light
                    ? [
                      const BoxShadow(
                        color: Color.fromARGB(15, 0, 0, 0),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ]
                    : null,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Container(
        color: colorScheme.surface,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          children: [
            // Filter Button Section
            SizedBox(
              height: 35,
              width: 80,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.filter_list, size: 16),
                label: const Text('Filter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007BFF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 1.0,
                    vertical: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Product Grid Section
            LayoutBuilder(
              builder: (context, constraints) {
                final isLandscape =
                    MediaQuery.of(context).orientation == Orientation.landscape;
                // Use more columns in landscape
                final crossAxisCount = isLandscape ? 4 : 2;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: isLandscape ? 0.85 : 0.75,
                  ),
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    final product = productList[index];
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
}
