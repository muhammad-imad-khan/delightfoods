import 'package:DelightFoods/Order/Order_api_handler.dart';
import 'package:DelightFoods/Order/OrderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({Key? key}) : super(key: key);

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  final _formKey = GlobalKey<FormBuilderState>();
  ApiHandler apiHandler = ApiHandler();

  void addOrder() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;

      final order = Order(
        id: 0,
        productId: 0,
        customerId: 0,
        customerName: null,
        quantity: int.tryParse(data['quantity'] ?? '0') ?? 0,
        totalPrice: double.tryParse(data['totalPrice'] ?? '0') ?? 0,
        advancePayment: double.tryParse(data['advancePayment'] ?? '0') ?? 0,
        remainingPayment: double.tryParse(data['remainingPayment'] ?? '0') ?? 0,
        status: data['status'] ?? '',
        reason: null,
        returnDate: null,
        shippingId: int.tryParse(data['shippingId'] ?? '0') ?? 0,
        createdOnUTC: DateTime.now(),
        createdStringDate: null,
        productName: null,
        paymentType: data['paymentType'] ?? '',
        shippingAddress: data['shippingAddress'] ?? '',
        paymentId: 0,
        cashOnDelivery: data['cashOnDelivery'] ?? false,
        cartDTOs: [],
        saleOrderProductMappings: [],
        taxRate: null,
        withholdingTax: null,
        cardholderName: null,
        cardNumber: null,
        expiry: null,
        cvc: 0,
        isReturnDateValid: false,
      );

      await apiHandler.addOrder(order: order);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Order"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        color: Colors.green,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: addOrder,
        child: const Text('Add'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'quantity',
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'totalPrice',
                decoration: const InputDecoration(labelText: 'Total Price'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'advancePayment',
                decoration: const InputDecoration(labelText: 'Advance Payment'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'remainingPayment',
                decoration: const InputDecoration(labelText: 'Remaining Payment'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'status',
                decoration: const InputDecoration(labelText: 'Status'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'shippingId',
                decoration: const InputDecoration(labelText: 'Shipping ID'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'paymentType',
                decoration: const InputDecoration(labelText: 'Payment Type'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'shippingAddress',
                decoration: const InputDecoration(labelText: 'Shipping Address'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderCheckbox(
                name: 'cashOnDelivery',
                title: const Text('Cash on Delivery'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
