import 'package:flutter/foundation.dart';

class Movie with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String price;
  final String imageUrl;
  

  Movie({
    @required this.id,
    @required this.title,
    @required this.description,
    this.price = '\$15.99',
    @required this.imageUrl,
  });

  






}