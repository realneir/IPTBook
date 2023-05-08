import 'package:flutter/foundation.dart';

class User {
  final String username;

  User({required this.username});
}

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }
}
