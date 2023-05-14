import 'package:flutter/material.dart';
import 'Book.dart';
import 'NetworkService.dart';

class BookPage extends StatefulWidget {
  final String token;

  BookPage({required this.token});

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  Future<List<Book>>? _futureBooks;

  @override
  void initState() {
    super.initState();
    _futureBooks =
        NetworkService().fetchBooks(widget.token) as Future<List<Book>>?;
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
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(snapshot.data![index].author),
                  trailing: Text(
                      'Available Copies: ${snapshot.data![index].availableCopies}'),
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
