import 'dart:convert';

import 'package:playground/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserServive {
  Future<List<UserModel>> fetchUser() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      if (response.statusCode == 200) {
        return UserModel.userList(jsonDecode(response.body));
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
