import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookDetailsScreen extends StatefulWidget {
  final int bookId;

  BookDetailsScreen({required this.bookId});

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  Future<void> rentBook() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/books/rentals/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // Assume 'token' is your authentication token
        'Authorization': 'Token <token>',
      },
      body: jsonEncode(<String, String>{
        'book': widget.bookId.toString(),
        // Assume 'userProfileId' is the ID of the user's profile
        'user_profile': '<userProfileId>',
        'rental_days': '7', // Assume the book is rented for 7 days
      }),
    );

    if (response.statusCode == 200) {
      print('Book rented successfully');
    } else {
      throw Exception('Failed to rent book');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rent a Book'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: rentBook,
          child: Text('Rent this book'),
        ),
      ),
    );
  }
}
