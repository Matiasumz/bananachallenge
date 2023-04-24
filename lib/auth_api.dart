import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const API = 'https://dummyjson.com';
  static const LOGIN = '/auth/login';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$API$LOGIN'),
      body: {'username': email, 'password': password},
    );
    final responseData = json.decode(response.body);
    return responseData;
  }
}
