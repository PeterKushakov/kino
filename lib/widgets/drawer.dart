import 'package:flutter/material.dart';
import 'package:kino/screens/edit.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                image: AssetImage('assets/globe.jpg'),
              ),
            ),
            child: Text(
              'Cinema World',
              style: TextStyle(
                color: Colors.yellow[600],
                fontSize: 50,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('All Movies'),
            onTap: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.local_activity),
            title: Text('My Tickets'),
            onTap: () {
              Navigator.of(context).pushNamed('/tickets');
            },
          ),
          ListTile(
            leading: Icon(Icons.mode_edit),
            title: Text('Add Movie'),
            onTap: () {
              Navigator.of(context).pushNamed(EditMovie.routeName);
            },
          ),
        ],
      ),
    );
  }
}
