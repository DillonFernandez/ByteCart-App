import 'package:flutter/material.dart';

// Cart state using ValueNotifier
ValueNotifier<List<Map<String, dynamic>>> cartItems = ValueNotifier([]);

class ProductCard extends StatelessWidget {
  final bool? newStock;
  final String imagePath;
  final String productName;
  final double price;
  final bool isInStock;
  final int availableStock;
  final double? salePercentage;

  const ProductCard({
    super.key,
    this.newStock,
    required this.imagePath,
    required this.productName,
    required this.price,
    required this.isInStock,
    required this.availableStock,
    this.salePercentage,
  });

  @override
  Widget build(BuildContext context) {
    // Price calculation
    final discountedPrice =
        (salePercentage ?? 0) > 0 ? price * (1 - salePercentage! / 100) : price;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Container(
      decoration: BoxDecoration(
        color:
            isDark
                ? const Color(0xFF121212)
                : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image and badges
              Expanded(
                child: Stack(
                  children: [
                    // Product image with cache for performance
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        cacheWidth: 400,
                        cacheHeight: 400,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                    // Stock and sale badges
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isInStock || availableStock < 5)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isInStock ? Colors.orange : Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                isInStock
                                    ? 'Only $availableStock left!'
                                    : 'Out of Stock',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          if ((salePercentage ?? 0) > 0)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${salePercentage!.toStringAsFixed(0)}% OFF',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // "New" badge
                    if (newStock == true)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'New',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Product name
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  productName,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Product price
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'LKR. ${price.toStringAsFixed(2)}',
                  style: TextStyle(color: textColor, fontSize: 15),
                ),
              ),
              // Add to Cart button
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isInStock ? const Color(0xFF007BFF) : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed:
                        isInStock
                            ? () {
                              // Add or update cart item
                              final index = cartItems.value.indexWhere(
                                (item) => item['name'] == productName,
                              );
                              if (index != -1) {
                                final newItems =
                                    List<Map<String, dynamic>>.from(
                                      cartItems.value,
                                    );
                                newItems[index] = Map<String, dynamic>.from(
                                  newItems[index],
                                );
                                newItems[index]['quantity'] =
                                    newItems[index]['quantity'] + 1;
                                cartItems.value = newItems;
                              } else {
                                cartItems.value = [
                                  ...cartItems.value,
                                  {
                                    'name': productName,
                                    'price': price,
                                    'discountedPrice': discountedPrice,
                                    'salePercentage': salePercentage,
                                    'image': imagePath,
                                    'quantity': 1,
                                  },
                                ];
                              }
                              // Confirmation dialog
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  final isDark =
                                      Theme.of(context).brightness ==
                                      Brightness.dark;
                                  return AlertDialog(
                                    backgroundColor:
                                        isDark
                                            ? const Color(0xFF121212)
                                            : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    title: const Text('Success'),
                                    content: Text(
                                      '$productName added to cart.',
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed:
                                            () => Navigator.of(context).pop(),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF007BFF,
                                          ),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            : null,
                    child: Text(
                      isInStock ? 'Add to Cart' : 'Out of Stock',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
