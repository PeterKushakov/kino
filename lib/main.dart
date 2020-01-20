import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/movie_deteil.dart';

import './screens/all_movies.dart';
//import './providers/movie.dart';
import './providers/movies.dart';
//import './providers/ticket.dart';
import './screens/edit.dart';

//void main() => runApp(MyApp());

void main() {
  Provider.debugCheckInvalidValueType = null;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Movies>(create: (_) => Movies()),
        //Provider<Movie>(create: (_) => Movie()),
        //Provider<Ticket>(create: (_) => Ticket()),
      ],
      child: MaterialApp(
        
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.yellow[600],
        ),
        home: AllMovies(),
        routes: {
         // MyTickets.routeName: (ctx) => MyTickets(),
          MovieDeteil.routeName: (ctx) => MovieDeteil(),
          EditMovie.routeName: (ctx) => EditMovie(),
        },
      ),
    );
  }
}
