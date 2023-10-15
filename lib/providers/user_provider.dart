import 'package:csse_app/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void updateUser(UserModel newUser) {
    _user = newUser;
    notifyListeners();
  }
}
