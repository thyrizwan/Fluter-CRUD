// ignore_for_file: dead_code

import 'package:flutter/material.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameTEController =
      TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _productImageTEController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _buildNewProductForm(context),
      ),
    );

    void onTapAddNewButton() {}

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
          TextFormField(
            controller: _productNameTEController,
            decoration: const InputDecoration(
              labelText: "Product Name",
              hintText: "Product Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _productCodeTEController,
            decoration: const InputDecoration(
              labelText: "Product Code",
              hintText: "Product Code",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _quantityTEController,
            decoration: const InputDecoration(
              labelText: "Quantity",
              hintText: "Quantity",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _unitPriceTEController,
            decoration: const InputDecoration(
              labelText: "Unit Price",
              hintText: "Unit Price",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _totalPriceTEController,
            decoration: const InputDecoration(
              labelText: "Total Price",
              hintText: "Total Price",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _productImageTEController,
            decoration: const InputDecoration(
              labelText: "Product Image",
              hintText: "Product Image",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _onTapUpdateProductButton,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(double.maxFinite),
            ),
            child: const Text("Update Product's Information"),
          ),
        ],
      ),
    );
  }

  void _onTapUpdateProductButton() {
    print("Tapped Update Button");
  }
}
