import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'OrderModel.dart';
import 'Order_api_handler.dart';
import 'add_Order.dart';
import 'edit_Order.dart';
import 'find_Order.dart';
import '../Auth/LoginAuthProvider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  ApiHandler apiHandler = ApiHandler();
  List<Order> data = [];
  bool isGrid = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      List<Order> fetchedData = await apiHandler.getOrderData();
      setState(() {
        data = fetchedData;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching orders: $e')),
      );
    }
  }

  void deleteOrder(int id) async {
    try {
      await apiHandler.deleteOrder(id: id);
      getData(); // Refresh data after deletion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting order: $e')),
      );
    }
  }

  void addOrder(Order order) async {
    try {
      await apiHandler.addOrder(order: order);
      getData(); // Refresh data after adding
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding order: $e')),
      );
    }
  }

  void editOrder(Order order) async {
    try {
      await apiHandler.updateOrder(id: order.id, order: order);
      getData(); // Refresh data after editing
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating order: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () =>
                Provider.of<LoginAuthProvider>(context, listen: false)
                    .logout(context),
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
                  builder: ((context) => const FindOrder()),
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
            onPressed: () async {
              final newOrder = await Navigator.push<Order>(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddOrder(),
                ),
              );
              if (newOrder != null) {
                addOrder(newOrder);
              }
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
              children: const [
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
        return buildOrderCard(data[index]);
      },
    );
  }

  Widget buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return buildOrderCard(data[index]);
      },
    );
  }

  Widget buildOrderCard(Order order) {
    Color statusColor;
    switch (order.status) {
      case 'Pending':
        statusColor = Colors.orange;
        break;
      case 'Delivered':
        statusColor = Colors.green;
        break;
      case 'Cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
        break;
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.shippingAddress,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Chip(
                  backgroundColor: statusColor,
                  label: Text(
                    order.status,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  '\$${order.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                 Text(
                  'Product Name: ${order.productName ?? ''}',
                ),
                Text(
                  'Advance Payment: ${order.advancePayment}',
                ),
                Text(
                  'Remaining Payment: ${order.remainingPayment}',
                ),
               
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () async {
                  final editedOrder = await Navigator.push<Order>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditOrder(order: order),
                    ),
                  );
                  if (editedOrder != null) {
                    editOrder(editedOrder);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  deleteOrder(order.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
