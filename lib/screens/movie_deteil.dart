import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../widgets/drawer.dart';
import '../providers/movies.dart';
import '../screens/edit.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';

class MovieDeteil extends StatelessWidget {
  static const routeName = '/deteils';

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context).settings.arguments as String;
    final movie = Provider.of<Movies>(
      context,
      listen: false,
    ).findById(movieId);

    final Widget titleSection = Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 20,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    movie.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final Widget textSection = Container(
      padding: EdgeInsets.symmetric(
        horizontal: 35,
        
      ),
      child: Text(
        movie.description,
        softWrap: true,
      ),
    );

   

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditMovie.routeName, arguments: movie.id);
            },
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Stack(
              children:<Widget> [ SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 15, 70, 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    child: Image.network(
                      movie.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(5, 10),
                          blurRadius: 10.0),
                    ]),
                  ),
                ),
              ),

              titleSection,
              textSection,
              
              // Container(
              //   width: 340,
              //   height: 170,
              //   margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: NetworkImage(
              //         movie.imageUrl,
              //       ),
              //       fit: BoxFit.cover,
              //     ),
              //     borderRadius: BorderRadius.circular(15),
              //     boxShadow: [
              //       BoxShadow(
              //           color: Colors.black26,
              //           offset: Offset(0, 2),
              //           blurRadius: 10.0),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
          Positioned(
            right: 20,
            bottom: 20,
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                child: Icon(Icons.shopping_cart),
                onPressed: () {
                  //const url = 'https://kino-9b678.firebaseio.com/tickets.json';

    // http.post(
    //   url,
    //   body: json.encode({
    //     'title': movie.title,
    //     'price': movie.price,
    //   }),
    // );
    
    
                },
                backgroundColor: Colors.yellow,
                elevation: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


 