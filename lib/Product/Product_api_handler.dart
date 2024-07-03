import 'dart:convert';
import 'package:DelightFoods/Product/ProductModel.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String baseUri = "http://192.168.1.4/api/Product";

 Future<List<Product>> getProductData() async {
  List<Product> data = [];

  final uri = Uri.parse(baseUri);
  try {
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final List<dynamic> jsonData = json.decode(response.body);
      print(jsonData);
      data = jsonData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load product data');
    }
  } catch (e) {
    print('Error fetching products: $e');
    throw Exception('Error fetching products: $e');
  }
  return data;
  }


  Future<http.Response> updateProduct({required int id, required Product product}) async {
    final uri = Uri.parse("$baseUri/Update/$id");
    late http.Response response;

    try {
      response = await http.put(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: json.encode(product.toJson()),
      );
    } catch (e) {
      print('Error updating product: $e');
      throw Exception('Failed to update product');
    }

    return response;
  }

  Future<http.Response> addProduct({required Product product}) async {
    final uri = Uri.parse("$baseUri/Add");
    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: json.encode(product.toJson()),
      );
      return response;
    } catch (e) {
      print('Error adding product: $e');
      throw Exception('Failed to add product');
    }
  }

  Future<http.Response> deleteProduct({required int id}) async {
    final uri = Uri.parse("$baseUri/Delete/$id");
    late http.Response response;

    try {
      response = await http.delete(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );
    } catch (e) {
      print('Error deleting product: $e');
      throw Exception('Failed to delete product');
    }
    return response;
  }

  Future<Product> getProductById({required int id}) async {
    final uri = Uri.parse("$baseUri/GetById/$id");
    Product? product;

    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        product = Product.fromJson(jsonData);
      }
    } catch (e) {
      print('Error fetching product by ID: $e');
      throw Exception('Failed to fetch product by ID');
    }
    return product!;
  }
}
