import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Auth/userModel.dart';

class RegisterAuthProvider with ChangeNotifier {
  Future<void> register(User user) async {
    final url =
        Uri.parse('http://192.168.1.4/api/Authenticate/register');
    print(url);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );
      print(response);

      if (response.statusCode == 200) {
        print('Registration Successful.');
      } else {
        // Handle error
        throw Exception(
            'Failed to register. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      throw Exception('Failed to register. Error: $error');
    }
  }
}
