import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/movie_deteil.dart';
import '../providers/movie.dart';

class MovieItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<Movie>(context, listen: false);
    final price = movie.price;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          MovieDeteil.routeName,
          arguments: movie.id,
        );
      },
      child: Container(
        width: 300,
        height: 700,
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              style: BorderStyle.solid,
              color: Colors.black,
            ),
            image: DecorationImage(
              image: NetworkImage(
                movie.imageUrl,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 10.0),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                ' ' + movie.title + ' ',
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.black54,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    ' only $price ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      backgroundColor: Colors.black54,
                      color: Colors.grey[50],
                    ),
                  ),
                  Text(
                    ' 3D | IMAX | 2D | 4D ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      backgroundColor: Colors.black54,
                      color: Colors.grey[50],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
