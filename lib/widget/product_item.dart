import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:myapp/models/products.dart';
import 'package:myapp/screen/update_product_screen.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product, this.onDelete});

  final Product product;
  final VoidCallback? onDelete;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Colors.white,
      title:
          Text(widget.product.productName ?? "Product Name is Not Available"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Product Code: ${widget.product.productCode ?? "Not Available"}"),
          Text("Quantity: ${widget.product.quantity ?? "Not Available"}"),
          Text(
              "Unit Price: ₹${widget.product.productUnitPrice ?? "Not Available"}"),
          Text("Total Price: ${widget.product.totalPrice ?? "Not Available"}"),
          const Divider(),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: _inProgress ? null : () => _deleteProduct(context),
                label: Text(
                  _inProgress ? "Deleting..." : "Delete",
                  style: const TextStyle(color: Colors.red),
                ),
                icon: Icon(
                  _inProgress ? Icons.hourglass_empty : Icons.delete,
                  color: Colors.red,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateProductScreen(
                        product: widget.product,
                      ),
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

  Future<void> _deleteProduct(BuildContext context) async {
    _inProgress = true;
    setState(() {});

    Uri uri = Uri.parse(
        'http://164.68.107.70:6060/api/v1/DeleteProduct/${widget.product.id}');

    Response response = await get(uri, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      _showSuccessSnackBar(context);
      if (widget.onDelete != null) {
        widget.onDelete!();
      }
    } else {
      _showFailureSnackBar(context);
    }

    setState(() {});
    _inProgress = false;
  }

  void _showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully Deleted!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showFailureSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Operation failed. Please try again.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
