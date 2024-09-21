class Product {
  final String id;
  final String productName;
  final String productCode;
  final int quantity;
  final double productUnitPrice;
  final double totalPrice;
  final String productImage;
  final String createdAt;

  Product({
    required this.id,
    required this.productName,
    required this.productCode,
    required this.quantity,
    required this.productUnitPrice,
    required this.totalPrice,
    required this.productImage,
    required this.createdAt,
  });
}
