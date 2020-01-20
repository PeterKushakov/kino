import 'package:flutter/material.dart';
import 'package:kino/widgets/movie_item.dart';
import 'package:provider/provider.dart';

import '../providers/movies.dart';

class MovieList extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<Movies>(context);
    final movies = moviesData.items;

    return ListView.builder(
      itemCount: movies.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: movies[i],
        child: MovieItem(),
      ),
    );
  }
}
