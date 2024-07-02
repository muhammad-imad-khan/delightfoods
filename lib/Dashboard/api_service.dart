import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'https://558e-202-47-48-55.ngrok-free.app/api/Product';

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
