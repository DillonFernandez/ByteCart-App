class ElectronicProduct {
  final bool newStock;
  final String imagePath;
  final String productName;
  final double price;
  final int availableStock;
  final bool isInStock;
  final bool isOnSale;
  final double? salePercentage;

  ElectronicProduct({
    required this.newStock,
    required this.imagePath,
    required this.productName,
    required this.price,
    required this.availableStock,
    required this.isInStock,
    this.isOnSale = false,
    this.salePercentage,
  });
}
