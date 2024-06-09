import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:DelightFoods/Order/Order_api_handler.dart';
import 'package:DelightFoods/Order/OrderModel.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;

class EditOrder extends StatefulWidget {
  final Order order;
  const EditOrder({Key? key, required this.order}) : super(key: key);

  @override
  State<EditOrder> createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
  final _formKey = GlobalKey<FormBuilderState>();
  ApiHandler apiHandler = ApiHandler();
  late http.Response response;

  void updateData() async {
    try {
      if (_formKey.currentState!.saveAndValidate()) {
        final data = _formKey.currentState!.value;

        final updatedOrder = Order(
          id: widget.order.id,
          productId: data['productId'],
          customerId: data['customerId'],
          customerName: data['customerName'],
          quantity: data['quantity'],
          totalPrice: data['totalPrice'],
          advancePayment: data['advancePayment'],
          remainingPayment: data['remainingPayment'],
          status: data['status'],
          reason: data['reason'],
          returnDate: data['returnDate'],
          shippingId: data['shippingId'],
          createdOnUTC: data['createdOnUTC'],
          createdStringDate: data['createdStringDate'],
          productName: data['productName'],
          paymentType: data['paymentType'],
          shippingAddress: data['shippingAddress'],
          paymentId: data['paymentId'],
          cashOnDelivery: data['cashOnDelivery'],
          cartDTOs: data['cartDTOs'],
          saleOrderProductMappings: data['saleOrderProductMappings'],
          taxRate: data['taxRate'],
          withholdingTax: data['withholdingTax'],
          cardholderName: data['cardholderName'],
          cardNumber: data['cardNumber'],
          expiry: data['expiry'],
          cvc: data['cvc'],
          isReturnDateValid: data['isReturnDateValid'],
        );

        response = await apiHandler.updateOrder(id: widget.order.id, order: updatedOrder);

        if (response.statusCode == 200) {
          Navigator.pop(context, true); // Pass true to indicate success
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update order. Status code: ${response.statusCode}'),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating order: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Order"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        color: Colors.teal,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: updateData,
        child: const Text('Update'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,
          initialValue: {
            'productId': widget.order.productId,
            'customerId': widget.order.customerId,
            'customerName': widget.order.customerName,
            'quantity': widget.order.quantity,
            'totalPrice': widget.order.totalPrice,
            'advancePayment': widget.order.advancePayment,
            'remainingPayment': widget.order.remainingPayment,
            'status': widget.order.status,
            'reason': widget.order.reason,
            'returnDate': widget.order.returnDate,
            'shippingId': widget.order.shippingId,
            'createdOnUTC': widget.order.createdOnUTC,
            'createdStringDate': widget.order.createdStringDate,
            'productName': widget.order.productName,
            'paymentType': widget.order.paymentType,
            'shippingAddress': widget.order.shippingAddress,
            'paymentId': widget.order.paymentId,
            'cashOnDelivery': widget.order.cashOnDelivery,
            'cartDTOs': widget.order.cartDTOs,
            'saleOrderProductMappings': widget.order.saleOrderProductMappings,
            'taxRate': widget.order.taxRate,
            'withholdingTax': widget.order.withholdingTax,
            'cardholderName': widget.order.cardholderName,
            'cardNumber': widget.order.cardNumber,
            'expiry': widget.order.expiry,
            'cvc': widget.order.cvc,
            'isReturnDateValid': widget.order.isReturnDateValid,
          },
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'productId',
                decoration: const InputDecoration(labelText: 'Product ID'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              // Add more form fields for other properties as needed
              // Example:
              // FormBuilderTextField(
              //   name: 'customerId',
              //   decoration: const InputDecoration(labelText: 'Customer ID'),
              //   keyboardType: TextInputType.number,
              //   validator: FormBuilderValidators.compose([
              //     FormBuilderValidators.required(),
              //     FormBuilderValidators.numeric(),
              //   ]),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
