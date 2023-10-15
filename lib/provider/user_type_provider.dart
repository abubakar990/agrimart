// user_type_provider.dart

import 'package:flutter/material.dart';

class UserTypeProvider with ChangeNotifier {
  late UserType _selectedUserType;

  UserType get selectedUserType => _selectedUserType;

  void setUserType(UserType userType) {
    _selectedUserType = userType;
    notifyListeners();
  }
}

enum UserType { farmer, buyer }
