import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }

    return null;
  }

  Future<void> signUp(String email, String password) async {
    try {
      final String url =
          "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[ApiKey]";

      final response = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      final responseData = json.decode(response.body);
      if (responseData["error"] != null) {
        throw HttpException("Something went Wrong with Singup!!");
      }

      _token = responseData["idToken"];
      _userId = responseData["localId"];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData["expiresIn"]),
        ),
      );

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> logIn(String email, String password) async {
    try {
      final String url =
          "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[Api_key]";

      final response = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      final responseData = json.decode(response.body);
      if (responseData["error"] != null) {
        throw HttpException("Something went Wrong with Login!!");
      }

      _token = responseData["idToken"];
      _userId = responseData["localId"];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData["expiresIn"]),
        ),
      );

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
