import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:myapp/models/products.dart';
import 'package:myapp/screen/add_new_product_screen.dart';
import 'package:myapp/widget/product_item.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productsList = [];

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          itemCount: productsList.length,
          itemBuilder: (context, index) {
            return ProductItem(
              product: productsList[index],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 4,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onFloatingAddButtonTap,
        child: const Icon(Icons.add),
      ),
    );
  }

  void onFloatingAddButtonTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewProductScreen(),
      ),
    );
  }

  Future<void> getProducts() async {
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/ReadProduct');
    Response response = await get(uri);
    productsList = [];
    if (response.statusCode == 200) {
      // Map<String, dynamic> responseBody = response.body as Map<String, dynamic>;
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      for (var item in responseBody['data']) {
        Product currentProdutct = Product(
          id: item['_id'],
          productName: item['ProductName'],
          productCode: item['ProductCode'],
          quantity: item['Qty'],
          productUnitPrice: item['UnitPrice'],
          totalPrice: item['TotalPrice'],
          productImage: item['img'],
          createdAt: item['CreatedDate'],
        );
        productsList.add(currentProdutct);
      }
    }
    setState(() {});
  }
}
