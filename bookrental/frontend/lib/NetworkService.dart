import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Book.dart';

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

  Future<bool> register(String username, String password, String email) async {
    var url = Uri.parse('$baseUrl/users/register/');

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'email': email,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Book>> fetchBooks(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/books/'),
      headers: {'Authorization': 'Token $token'},
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Iterable json = jsonDecode(response.body);
      return List<Book>.from(json.map((model) => Book.fromJson(model)));
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<void> rentBook(String token, int bookId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/books/rentals/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(<String, String>{
        'book': bookId.toString(),
        // Assume 'userProfileId' is the ID of the user's profile
        'user_profile': '<userProfileId>',
        'rental_days': '7', // Assume the book is rented for 7 days
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to rent book');
    }
  }
}
