import 'package:DelightFoods/Auth/LoginAuthProvider.dart';
import 'package:DelightFoods/Product/add_Product.dart';
import 'package:DelightFoods/Product/Product_api_handler.dart';
import 'package:DelightFoods/Product/edit_Product.dart';
import 'package:DelightFoods/Product/find_product.dart';
import 'package:DelightFoods/Product/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Auth/AuthScreens/login.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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

  bool isGrid = true;

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
                  builder: (context) => const AddProduct()),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ToggleButtons(
              isSelected: [isGrid, !isGrid],
              onPressed: (index) {
                setState(() {
                  isGrid = index == 0;
                });
              },
              children: [
                Icon(Icons.grid_view),
                Icon(Icons.list),
              ],
            ),
          ),
          Expanded(
            child: isGrid ? buildGridView() : buildListView(),
          ),
        ],
      ),
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    data[index].mediaFilePath ?? 'data:image/jpeg;base64,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', // Provide a placeholder URL
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data[index].description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${data[index].price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPage(product: data[index]),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      deleteProduct(data[index].id);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPage(product: data[index]),
                ),
              );
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(data[index].mediaFilePath ?? 'https://via.placeholder.com/150'),
              onBackgroundImageError: (_, __) => const Icon(Icons.error),
            ),
            title: Text(
              data[index].name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data[index].description),
                const SizedBox(height: 4),
                Text(
                  '\$${data[index].price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                deleteProduct(data[index].id);
              },
            ),
          ),
        );
      },
    );
  }
}
