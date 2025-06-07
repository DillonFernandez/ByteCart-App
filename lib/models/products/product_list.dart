import 'package:bytecart/models/products/product_type.dart';

final List<ElectronicProduct> productList = [
  // Smart Home Devices
  ElectronicProduct(
    newStock: false,
    imagePath: "assets/images/products/Google Nest Hub (2nd Gen).webp",
    productName: "Google Nest Hub (2nd Gen)",
    price: 7999.0,
    availableStock: 0,
    isInStock: false,
  ),

  // Monitors
  ElectronicProduct(
    newStock: true,
    imagePath: "assets/images/products/Samsung Odyssey G9.webp",
    productName: "Samsung Odyssey G9",
    price: 149999.0,
    availableStock: 10,
    isInStock: true,
    isOnSale: true,
    salePercentage: 10.0,
  ),

  // Drones
  ElectronicProduct(
    newStock: false,
    imagePath: "assets/images/products/DJI Air 3.webp",
    productName: "DJI Air 3",
    price: 120000.0,
    availableStock: 0,
    isInStock: false,
  ),

  // Gaming Consoles
  ElectronicProduct(
    newStock: true,
    imagePath: "assets/images/products/PlayStation 5 Slim.webp",
    productName: "PlayStation 5 Slim",
    price: 49999.0,
    availableStock: 30,
    isInStock: true,
    isOnSale: true,
    salePercentage: 15.0,
  ),

  // Smartphones
  ElectronicProduct(
    newStock: true,
    imagePath: "assets/images/products/Samsung Galaxy S24 Ultra.webp",
    productName: "Samsung Galaxy S24 Ultra",
    price: 129999.0,
    availableStock: 20,
    isInStock: true,
  ),

  // Smartwatches
  ElectronicProduct(
    newStock: false,
    imagePath: "assets/images/products/Garmin Fenix 7 Pro.webp",
    productName: "Garmin Fenix 7 Pro",
    price: 99999.0,
    availableStock: 0,
    isInStock: false,
  ),

  // Tablets
  ElectronicProduct(
    newStock: true,
    imagePath: "assets/images/products/iPad Pro M3.webp",
    productName: "iPad Pro M3",
    price: 99999.0,
    availableStock: 20,
    isInStock: true,
    isOnSale: true,
    salePercentage: 20.0,
  ),

  // Wireless Earbuds
  ElectronicProduct(
    newStock: false,
    imagePath: "assets/images/products/Sony WF-1000XM5.webp",
    productName: "Sony WF-1000XM5",
    price: 24999.0,
    availableStock: 50,
    isInStock: true,
    isOnSale: true,
    salePercentage: 5.0,
  ),

  // Wireless Headphones
  ElectronicProduct(
    newStock: false,
    imagePath:
        "assets/images/products/Bose Noise Cancelling Headphones 700.webp",
    productName: "Bose Noise Cancelling Headphones 700",
    price: 29999.0,
    availableStock: 30,
    isInStock: true,
  ),

  // Cameras
  ElectronicProduct(
    newStock: false,
    imagePath: "assets/images/products/Canon EOS R6 Mark II.webp",
    productName: "Canon EOS R6 Mark II",
    price: 249999.0,
    availableStock: 4,
    isInStock: true,
  ),
];
