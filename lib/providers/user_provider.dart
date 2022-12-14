import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';

//

class UserProvider with ChangeNotifier { // ChangeNotifier is A class that can be extended or mixed in that provides a change notification API using VoidCallback for notifications.
  User? _user; // we should use user private to avoid bugs in the future
  final AuthMethods _authMethods = AuthMethods(); // AuthMethod class from auth_methods.dart

  User get getUser => _user!; // access the data in _user gotten from User class in user.dart and make sure not null is covered

  Future<void> refreshUser() async { // refreshUser function refreshes the user every time
    User user = await _authMethods.getUserDetails(); 
    _user = user;
    notifyListeners(); 
  }
}




