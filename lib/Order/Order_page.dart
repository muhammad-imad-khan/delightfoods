import 'package:DelightFoods/Auth/LoginAuthProvider.dart';
import 'package:DelightFoods/Product/add_Product.dart';
import 'package:DelightFoods/Product/Product_api_handler.dart';
import 'package:DelightFoods/Product/edit_Product.dart';
import 'package:DelightFoods/Product/find_product.dart';
import 'package:DelightFoods/Product/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Auth/AuthScreens/login.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  void _logout(BuildContext context) {
    Provider.of<LoginAuthProvider>(context, listen: false).logout(context);
  }

  ApiHandler apiHandler = ApiHandler();
  List<Product> data = [];

  void getData() async {
    List<Product> fetchedData = await apiHandler.getProductData();
    setState(() {
      data = fetchedData;
    });
  }

  void deleteProduct(int productId) async {
    await apiHandler.deleteProduct(id: productId);
    getData(); // Refresh data after deletion
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      bottomNavigationBar: MaterialButton(
        color: Colors.green,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: getData,
        child: const Text('Refresh'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 1,
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const FindProduct()),
                ),
              );
            },
            child: const Icon(Icons.search),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: 2,
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddProduct(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPage(product: data[index]),
                    ),
                  );
                },
                leading: Text("${data[index].id}"),
                title: Text(data[index].name),
                subtitle: Text(data[index].description),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    deleteProduct(data[index].id);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
