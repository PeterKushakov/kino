import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './movie.dart';

class Movies with ChangeNotifier {
  List<Movie> _items = [];

  List<Movie> get items {
    return [..._items];
  }

  Movie findById(String id) {
    return _items.firstWhere((mov) => mov.id == id);
  }

  Future<void> fetchAndSetMovies() async {
    const url = 'https://kino-9b678.firebaseio.com/movies.json';
    
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    final List<Movie> loadedMovies = [];
    extractedData.forEach((movieId, movieData) {
      loadedMovies.add(Movie(
        id: movieId,
        title: movieData['title'],
        description: movieData['description'],
        price: movieData['price'],
        imageUrl: movieData['imageUrl'],
      ));
    });
    _items = loadedMovies;
  
    notifyListeners();
    }



  Future<void> addMovie(Movie movie) async {
    const url = 'https://kino-9b678.firebaseio.com/movies.json';

    final response = await http.post(
      url,
      body: json.encode({
        'title': movie.title,
        'description': movie.description,
        'imageUrl': movie.imageUrl,
        'price': movie.price,
      }),
    );
    final newMovie = Movie(
      title: movie.title,
      description: movie.description,
      price: movie.price,
      imageUrl: movie.imageUrl,
      id: json.decode(response.body)['name'],
    );
    _items.add(newMovie);
    
    notifyListeners();
  }

  Future<void> updateMovie(String id, Movie newMovie) async {
    final movIndex = _items.indexWhere((mov) => mov.id == id);
    if (movIndex >= 0) {
      final url = 'https://kino-9b678.firebaseio.com/movies/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newMovie.title,
            'description': newMovie.description,
            'imageUrl': newMovie.imageUrl,
            'price': newMovie.price
          }));
      _items[movIndex] = newMovie;
      notifyListeners();
    } else {
      print('...');
    }
  }
}
