import 'package:bytecart/models/constants/appbar.dart';
import 'package:bytecart/models/constants/productcard.dart';
import 'package:flutter/material.dart';

// Cart Page Main Widget
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final GlobalKey _stackKey = GlobalKey();

  // Confirmation Dialog
  Future<bool> _showConfirmDialog(String title, String content) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                backgroundColor:
                    isDark ? const Color(0xFF121212) : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text(title),
                content: Text(content),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Confirm'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  // Cart Summary Bottom Sheet
  void _showCartSummaryPopup(List<Map<String, dynamic>> items) {
    final total = items.fold<double>(
      0.0,
      (sum, item) => sum + item['discountedPrice'] * item['quantity'],
    );
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          decoration: BoxDecoration(
            color:
                isDark
                    ? const Color(0xFF121212)
                    : Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Cart Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total'),
                  Text(
                    'LKR. ${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007BFF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(child: Text('Proceed to Checkout')),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    Navigator.pop(context);
                    if (await _showConfirmDialog(
                      'Clear Cart',
                      'Are you sure you want to clear the cart?',
                    )) {
                      cartItems.value = [];
                    }
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Clear Cart'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Main Build Method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar.mainAppBar(context),
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: cartItems,
        builder: (context, items, _) {
          return Stack(
            key: _stackKey,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: OrientationBuilder(
                    builder: (context, orientation) {
                      if (items.isEmpty) {
                        return const Center(
                          child: Text(
                            'Your cart is empty.',
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }
                      // Efficient List/Grid for Large Data
                      return orientation == Orientation.portrait
                          ? ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            itemCount: items.length,
                            separatorBuilder:
                                (_, __) => const SizedBox(height: 10),
                            itemBuilder: (_, index) {
                              final item = items[index];
                              final isOnSale =
                                  item['salePercentage'] != null &&
                                  item['salePercentage'] > 0;
                              return _buildCartItem(
                                item,
                                index,
                                isOnSale,
                                items,
                              );
                            },
                          )
                          : GridView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                            itemCount: items.length,
                            itemBuilder: (_, index) {
                              final item = items[index];
                              final isOnSale =
                                  item['salePercentage'] != null &&
                                  item['salePercentage'] > 0;
                              return _buildCartItem(
                                item,
                                index,
                                isOnSale,
                                items,
                              );
                            },
                          );
                    },
                  ),
                ),
              ),
              if (items.isNotEmpty)
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    onPressed: () => _showCartSummaryPopup(items),
                    icon: const Icon(Icons.shopping_cart_checkout),
                    label: const Text('Cart Summary'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  // Cart Item Card
  Widget _buildCartItem(
    Map<String, dynamic> item,
    int index,
    bool isOnSale,
    List<Map<String, dynamic>> items,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:
            isDark
                ? const Color(0xFF121212)
                : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Optimized Image Loading
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item['image'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  cacheWidth: 160,
                  cacheHeight: 160,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    isOnSale
                        ? Wrap(
                          spacing: 6,
                          children: [
                            Text(
                              'LKR. ${item['price'].toStringAsFixed(2)}',
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'LKR. ${item['discountedPrice'].toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                        : Text(
                          'LKR. ${item['price'].toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 14),
                        ),
                    const SizedBox(height: 4),
                    Text(
                      'Subtotal: LKR. ${(item['discountedPrice'] * item['quantity']).toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Quantity Controls
              Container(
                decoration: BoxDecoration(
                  color:
                      isDark
                          ? const Color(0xFF121212)
                          : Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF007BFF).withOpacity(0.15),
                    width: 1.5,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () async {
                        if (item['quantity'] > 1) {
                          final newItems = List<Map<String, dynamic>>.from(
                            items,
                          );
                          newItems[index] = Map<String, dynamic>.from(
                            newItems[index],
                          );
                          newItems[index]['quantity']--;
                          cartItems.value = newItems;
                        } else {
                          if (await _showConfirmDialog(
                            'Remove Product',
                            'Are you sure you want to remove this product from the cart?',
                          )) {
                            final newItems = List<Map<String, dynamic>>.from(
                              items,
                            )..removeAt(index);
                            cartItems.value = newItems;
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF007BFF).withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.remove,
                          size: 20,
                          color: Color(0xFF007BFF),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        item['quantity'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        final newItems = List<Map<String, dynamic>>.from(items);
                        newItems[index] = Map<String, dynamic>.from(
                          newItems[index],
                        );
                        newItems[index]['quantity']++;
                        cartItems.value = newItems;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF007BFF).withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.add,
                          size: 20,
                          color: Color(0xFF007BFF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Remove Item Button
          Positioned(
            bottom: -8,
            right: -8,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                if (await _showConfirmDialog(
                  'Remove Product',
                  'Are you sure you want to remove this product from the cart?',
                )) {
                  final newItems = List<Map<String, dynamic>>.from(items)
                    ..removeAt(index);
                  cartItems.value = newItems;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
