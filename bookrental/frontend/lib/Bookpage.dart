import 'package:flutter/material.dart';
import 'Book.dart';
import 'NetworkService.dart';
import 'bookdetail.dart';

class BookPage extends StatefulWidget {
  final String token;

  BookPage({required this.token});

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  Future<List<Book>>? _futureBooks;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    try {
      _futureBooks = NetworkService().fetchBooks(widget.token);
    } catch (e, stackTrace) {
      _errorMessage = e.toString();
      print('Error fetching books: $_errorMessage');
      print('Stack trace: $stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
      body: FutureBuilder<List<Book>>(
        future: _futureBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || _errorMessage != null) {
            return Center(child: Text('An error occurred: $_errorMessage'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(snapshot.data![index].author),
                  trailing: Text(
                      'Available Copies: ${snapshot.data![index].availableCopies}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailsScreen(
                          token: widget.token,
                          book: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No books available'));
          }
        },
      ),
    );
  }
}
