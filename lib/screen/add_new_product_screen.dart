// ignore_for_file: unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

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
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
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
            onPressed: _onTapAddNewButton,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(double.maxFinite),
            ),
            child: const Text("Add New Product"),
          ),
        ],
      ),
    );
  }

  void _onTapAddNewButton() {
    if (_formKey.currentState!.validate()) {
      addNewProduct();
    }
  }

  Future<void> addNewProduct() async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/CreateProduct');
    Map<String, dynamic> requestBody = {
      "Img": "Here will be url",
      "ProductCode": "RANDOM_CODE",
      "ProductName": "Added by Rizwan Ansari",
      "Qty": "999999",
      "TotalPrice": "999999",
      "UnitPrice": "999999"
    };
    Response response = await post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody));
    if (response.statusCode == 200) {
      _showSuccessSnackBar();
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
