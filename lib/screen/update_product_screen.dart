// ignore_for_file: dead_code

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:myapp/models/products.dart';
import 'package:myapp/screen/product_list_screen.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});
  final Product product;
  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _productNameTEController;
  late TextEditingController _productCodeTEController;
  late TextEditingController _quantityTEController;
  late TextEditingController _unitPriceTEController;
  late TextEditingController _totalPriceTEController;
  late TextEditingController _productImageTEController;
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    _productNameTEController =
        TextEditingController(text: widget.product.productName);
    _productCodeTEController =
        TextEditingController(text: widget.product.productCode);
    _quantityTEController =
        TextEditingController(text: widget.product.quantity);
    _unitPriceTEController =
        TextEditingController(text: widget.product.productUnitPrice);
    _totalPriceTEController =
        TextEditingController(text: widget.product.totalPrice);
    _productImageTEController =
        TextEditingController(text: widget.product.productImage);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.product.productImage);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildNewProductForm(context),
        ),
      ),
    );

    @override
    void dispose() {
      _productNameTEController.dispose();
      _productCodeTEController.dispose();
      _quantityTEController.dispose();
      _unitPriceTEController.dispose();
      _totalPriceTEController.dispose();
      _productImageTEController.dispose();
      super.dispose();
    }
  }

  Widget _buildNewProductForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height:24),
          Text("Update Product", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
          const SizedBox(height:24),
          TextFormField(
            controller: _productNameTEController,
            decoration: const InputDecoration(
              labelText: "Product Name",
              hintText: "Product Name",
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
            value!.isEmpty ? "Please enter a value" : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _productCodeTEController,
            decoration: const InputDecoration(
              labelText: "Product Code",
              hintText: "Product Code",
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
            value!.isEmpty ? "Please enter a value" : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _quantityTEController,
            decoration: const InputDecoration(
              labelText: "Quantity",
              hintText: "Quantity",
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
            value!.isEmpty ? "Please enter a value" : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _unitPriceTEController,
            decoration: const InputDecoration(
              labelText: "Unit Price",
              hintText: "Unit Price",
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
            value!.isEmpty ? "Please enter a value" : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _totalPriceTEController,
            decoration: const InputDecoration(
              labelText: "Total Price",
              hintText: "Total Price",
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
            value!.isEmpty ? "Please enter a value" : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _productImageTEController,
            decoration: const InputDecoration(
              labelText: "Product Image",
              hintText: "Product Image",
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
            value!.isEmpty ? "Please enter a value" : null,
          ),
          const SizedBox(height: 26),
          ElevatedButton(
            onPressed: _onTapUpdateProductButton,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink.shade100, // background color
              foregroundColor: Colors.pink.shade800, // text color
              minimumSize: const Size(double.infinity, 50), // width and height
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text("Update Product's Information", style: TextStyle(fontSize: 18),),
          ),
        ],
      ),
    );
  }

  void _onTapUpdateProductButton() {
    if (_formKey.currentState!.validate()) {
      updateProductInformation();
    }
  }

  Future<void> updateProductInformation() async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse(
        'http://164.68.107.70:6060/api/v1/UpdateProduct/${widget.product.id}');
    Map<String, dynamic> requestBody = {
      "Img": _productImageTEController.text,
      "ProductCode": _productCodeTEController.text,
      "ProductName": _productNameTEController.text,
      "Qty": _quantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitPriceTEController.text
    };
    Response response = await post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody));
    if (response.statusCode == 200) {
      _showSuccessSnackBar();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductListScreen(),
          ),
              (value) => false);
    } else {
      _showFailureSnackBar();
    }
    _inProgress = false;
    setState(() {});
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully Added!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showFailureSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Operation failed. Please try again.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
