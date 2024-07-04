// lib/LoginAuthProvider.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginAuthProvider with ChangeNotifier {
  Future<void> login(String username, String password) async {
    final url = Uri.parse('http://192.168.1.12/api/Authenticate/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        print('Login Successful.');
      } else {
        // Handle error
        throw Exception('Failed to login');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> logout(BuildContext context) async {
    // Perform any local logout actions here (clear session, tokens, etc.)
    // For example:
    // clearSession();
    // clearTokens();

    // Navigate to the login screen
    Navigator.pushReplacementNamed(context, '/login');
  }
}
