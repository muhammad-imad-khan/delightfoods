import 'dart:convert';
import 'package:DelightFoods/Order/OrderModel.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String baseUri = "https://558e-202-47-48-55.ngrok-free.app/api/SaleOrder";

  Future<List<Order>> getOrderData() async {
    List<Order> data = [];

    final uri = Uri.parse("$baseUri/OrderListForAdmin");
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        print(jsonData);
        data = jsonData.map((json) => Order.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load Order data');
      }
    } catch (e) {
      print('Error fetching Orders: $e');
      throw Exception('Error fetching Orders: $e');
    }
    return data;
  }

  Future<http.Response> updateOrder({required int id, required Order order}) async {
    final uri = Uri.parse("$baseUri/Update/$id");
    late http.Response response;

    try {
      response = await http.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(order.toJson()),
      );
    } catch (e) {
      print('Error updating Order: $e');
      throw Exception('Failed to update Order');
    }

    return response;
  }

  Future<http.Response> addOrder({required Order order}) async {
    final uri = Uri.parse("$baseUri/Add");
    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(order.toJson()),
      );
      return response;
    } catch (e) {
      print('Error adding Order: $e');
      throw Exception('Failed to add Order');
    }
  }

  Future<http.Response> deleteOrder({required int id}) async {
    final uri = Uri.parse("$baseUri/Delete/$id");
    late http.Response response;

    try {
      response = await http.delete(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } catch (e) {
      print('Error deleting Order: $e');
      throw Exception('Failed to delete Order');
    }
    return response;
  }

  Future<Order> getOrderById({required int id}) async {
    final uri = Uri.parse("$baseUri/GetById/$id");
    Order? order;

    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        order = Order.fromJson(jsonData);
      }
    } catch (e) {
      print('Error fetching Order by ID: $e');
      throw Exception('Failed to fetch Order by ID');
    }
    return order!;
  }
}
