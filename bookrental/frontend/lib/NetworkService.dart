import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Book.dart';
import 'Bookpage.dart';

class NetworkService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  Future<String> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login/'),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['token'];
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<List<Book>> fetchBooks(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/books/'),
      headers: {'Authorization': 'Token $token'},
    );

    if (response.statusCode == 200) {
      Iterable json = jsonDecode(response.body);
      return List<Book>.from(json.map((model) => Book.fromJson(model)));
    } else {
      throw Exception('Failed to load books');
    }
  }
}