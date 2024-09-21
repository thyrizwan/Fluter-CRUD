import 'package:flutter/material.dart';
import 'package:myapp/models/products.dart';
import 'package:myapp/screen/update_product_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Colors.white,
      title: Text(product.productName ?? "Product Name is Not Available"),
      leading: const CircleAvatar(
        backgroundImage:
            NetworkImage("https://images.unsplash.com/photo-1500648767791-00"),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Product Code: ${product.productCode ?? "Not Available"}"),
          Text("Quantity: ${product.quantity ?? "Not Available"}"),
          Text("Unit Price: ₹${product.productUnitPrice ?? "Not Available"}"),
          Text("Total Price: ${product.totalPrice ?? "Not Available"}"),
          const Divider(),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: _onTapDeleteButton,
                label: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpdateProductScreen(),
                    ),
                  );
                },
                label: const Text("Edit"),
                icon: const Icon(Icons.edit),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _onTapEditButton() {
    print("Tapped");
  }

  void _onTapDeleteButton() {
    print("Tapped");
  }
}
