import 'package:flutter/material.dart';
import 'package:playground/service/service.dart';
import 'package:playground/model/user_model.dart';

class UserController extends ChangeNotifier {
  final _userService = UserServive();
  final List<UserModel> userList = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchUser() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();
      final users = await _userService.fetchUser();
      userList.addAll(users);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
