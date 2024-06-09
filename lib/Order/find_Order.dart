import 'package:DelightFoods/Product/Product_api_handler.dart';
import 'package:DelightFoods/Product/ProductModel.dart';
import 'package:flutter/material.dart';

class FindProduct extends StatefulWidget {
  const FindProduct({super.key});

  @override
  State<FindProduct> createState() => _FindProductState();
}

class _FindProductState extends State<FindProduct> {
  ApiHandler apiHandler = ApiHandler();
  Product product = const Product.empty();
  TextEditingController textEditingController = TextEditingController();

  void findProduct(int productId) async {
    product = await apiHandler.getProductById(id: productId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Product"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        color: Colors.green,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: () {
          findProduct(int.parse(textEditingController.text));
        },
        child: const Text('Find'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Text("${product.id}"),
              title: Text(product.name),
              subtitle: Text(product.price.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
