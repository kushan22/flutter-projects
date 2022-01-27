import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    final url =
        "https://flutter-projects-c08ba-default-rtdb.firebaseio.com/products/${id}";

    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final response = await http.patch(url,
          body: json.encode({
            "isFavorite": isFavorite,
          }));
      if (response.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
        throw HttpException("Could not update the Favorite!!");
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
      throw HttpException("Could not update the Favorite!!");
    }
  }
}
