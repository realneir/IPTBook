import 'package:flutter/material.dart';
import 'Book.dart';
import 'NetworkService.dart';

class BookDetailsScreen extends StatefulWidget {
  final String token;
  final Book book;

  BookDetailsScreen({required this.token, required this.book});

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  Future<void> _rentBook() async {
    if (widget.book.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book rented successfully')),
      );
      return;
    }

    try {
      await NetworkService().rentBook(widget.token, widget.book.id!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book rented successfully')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to rent book')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(widget.book.title, style: TextStyle(fontSize: 24)),
            Text(widget.book.author, style: TextStyle(fontSize: 18)),
            Text('Available Copies: ${widget.book.availableCopies}'),
            ElevatedButton(
              onPressed: _rentBook,
              child: Text('Rent this book'),
            ),
          ],
        ),
      ),
    );
  }
}
