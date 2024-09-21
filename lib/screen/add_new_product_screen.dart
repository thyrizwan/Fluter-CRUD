// ignore_for_file: unused_element

import 'package:flutter/material.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
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
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(double.maxFinite),
            ),
            child: const Text("Add New Product"),
          ),
        ],
      ),
    );
  }
}
