import 'package:flutter/material.dart';
import 'Order_api_handler.dart';
import 'OrderModel.dart';

class FindOrder extends StatefulWidget {
  const FindOrder({super.key});

  @override
  State<FindOrder> createState() => _FindOrderState();
}

class _FindOrderState extends State<FindOrder> {
  ApiHandler apiHandler = ApiHandler();
  Order? order;
  TextEditingController textEditingController = TextEditingController();
  String errorMessage = '';

  void findOrder(int orderId) async {
    try {
      Order fetchedOrder = await apiHandler.getOrderById(id: orderId);
      setState(() {
        order = fetchedOrder;
        errorMessage = '';
      });
    } catch (e) {
      setState(() {
        order = null;
        errorMessage = 'Order not found or error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Order"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        color: Colors.green,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: () {
          int orderId = int.tryParse(textEditingController.text) ?? -1;
          if (orderId > 0) {
            findOrder(orderId);
          } else {
            setState(() {
              errorMessage = 'Please enter a valid order ID';
              order = null;
            });
          }
        },
        child: const Text('Find'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                labelText: 'Enter Order ID',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 10,
            ),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            if (order != null)
              ListTile(
                leading: Text("${order!.id}"),
                title: Text(order!.shippingAddress),
                subtitle: Text(order!.totalPrice.toString()),
              ),
          ],
        ),
      ),
    );
  }
}
