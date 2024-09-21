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
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void _removeProduct(Product product) {
    setState(() {
      productsList.remove(product); // Remove the product from the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        actions: [
          IconButton(
            onPressed: () {
              getProducts();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: _inProgress
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.pink,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                itemCount: productsList.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                    product: productsList[index],
                    onDelete: () {
                      _removeProduct(productsList[
                          index]); // Optional: Remove product on delete
                    },
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
        backgroundColor: Colors.pink.shade50,
        onPressed: onFloatingAddButtonTap,
        child: const Icon(
          Icons.add,
          color: Colors.pink,
        ),
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
    _inProgress = true;
    setState(() {});
    productsList.clear();
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/ReadProduct');
    Response response = await get(uri);
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
          productImage: item['Img'],
          createdAt: item['CreatedDate'],
        );
        productsList.add(currentProdutct);
      }
    }
    _inProgress = false;
    setState(() {});
  }
}
