// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'user_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Book Rental System',
        initialRoute: '/',
        routes: {
          '/': (context) => LoginRegisterScreen(),
          '/main': (context) => MainScreen(),
          '/bookList': (context) => BookListScreen(),
          '/bookDetails': (context) => BookDetailsScreen(),
          '/register': (context) => RegisterScreen(),

          // '/rentalSummary': (context) => RentalSummaryScreen(),
          // '/transactions': (context) => TransactionsScreen(),
          '/addBook': (context) => AddBookScreen(),
        },
      ),
    ),
  );
}

class LoginRegisterScreen extends StatefulWidget {
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Make API request to verify login credentials and retrieve user data
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': _username,
          'password': _password,
        }),
      );

      if (response.statusCode == 200) {
        // Login successful, navigate to main screen
        Navigator.pushNamed(context, '/main');
      } else {
        // Login failed, display error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid login credentials'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid username';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _username = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/main');
                  },
                  child: Text('Log in'),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to register screen
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text('Don\'t have an account? Register here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Make API request to register new user
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/users/register/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': _username,
          'password': _password,
        }),
      );

      if (response.statusCode == 200) {
        // Login successful, navigate to main screen
        Navigator.pushNamed(context, '/MainScreen');
      } else {
        // Registration failed, display error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error registering user'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid username';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _username = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Register'),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to login screen
                    Navigator.pop(context);
                  },
                  child: Text('Already have an account? Log in here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/bookList');
              },
              child: Text('View Book List'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/transactions');
              },
              child: Text('View Transactions'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addBook');
              },
              child: Text('Add New Book'),
            ),
            ElevatedButton(
              onPressed: () {
// Logout user and navigate back to login/register screen
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<dynamic> _bookList = [];

  void _getBookList() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/api/books/'));
    if (response.statusCode == 200) {
      setState(() {
        _bookList = jsonDecode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to retrieve book list'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getBookList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
      ),
      body: Center(
        child: _bookList.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: _bookList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_bookList[index]['title']),
                    subtitle: Text(_bookList[index]['author']),
                    trailing: Text('${_bookList[index]['rental_price']}'),
                    onTap: () {
// Navigate to book details screen with selected book
                      Navigator.pushNamed(
                        context,
                        '/bookDetails',
                        arguments: _bookList[index],
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}

class BookDetailsScreen extends StatefulWidget {
  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late dynamic _book;
  int _rentalDuration = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _book = ModalRoute.of(context)!.settings.arguments;
  }

  void _rentBook() async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/rentals/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'book': _book['id'],
        'rental_duration': _rentalDuration,
      }),
    );
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Book rented successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_book['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Book details here...'), // Add book details widgets
            ElevatedButton(
              onPressed: _rentBook,
              child: Text('Rent Book'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddBookScreen extends StatefulWidget {
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _author = '';
  double _price = 0.0;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Make API request to add new book
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/books/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': _title,
          'author': _author,
          'price': _price,
        }),
      );

      if (response.statusCode == 201) {
        // Book added successfully, navigate back to book list screen
        Navigator.pop(context);
      } else {
        // Error adding book, display error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding book'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid title';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _title = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Author',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid author';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _author = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Price',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid price';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _price = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Add Book'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
