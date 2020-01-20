import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movie.dart';
import '../providers/movies.dart';

class EditMovie extends StatefulWidget {
  static const routeName = '/edit-movie';

  @override
  _EditMovieState createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedMovie = Movie(
    id: null,
    title: '',
    price: '\$15.99',
    description: '',
    imageUrl: '',
  );
  var _initValues = {
    'title': '',
    'description': '',
    'price': '\$15.99',
    'imageUrl': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final movieId = ModalRoute.of(context).settings.arguments as String;
      if (movieId != null) {
        _editedMovie =
            Provider.of<Movies>(context, listen: false).findById(movieId);
        _initValues = {
          'title': _editedMovie.title,
          'description': _editedMovie.description,
          'price': _editedMovie.price.toString(),
          'imageUrl': _editedMovie.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedMovie.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    setState(() {});
  }

  Future<void> _saveForm() async {
    
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedMovie.id != null) {
      await Provider.of<Movies>(context, listen: false)
          .updateMovie(_editedMovie.id, _editedMovie);
    } else {
       
        await Provider.of<Movies>(context, listen: false)
            .addMovie(_editedMovie);
      } 
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    // Navigator.of(context).pop();
    }
    
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Movie'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                     
                      onSaved: (value) {
                        _editedMovie = Movie(
                          title: value,
                          price: _editedMovie.price,
                          description: _editedMovie.description,
                          imageUrl: _editedMovie.imageUrl,
                          id: _editedMovie.id,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) {
                        _editedMovie = Movie(
                          title: _editedMovie.title,
                          price: _editedMovie.price,
                          description: _editedMovie.description,
                          imageUrl: _editedMovie.imageUrl,
                          id: _editedMovie.id,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                     
                      onSaved: (value) {
                        _editedMovie = Movie(
                          title: _editedMovie.title,
                          price: _editedMovie.price,
                          description: value,
                          imageUrl: _editedMovie.imageUrl,
                          id: _editedMovie.id,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            
                            onSaved: (value) {
                              _editedMovie = Movie(
                                title: _editedMovie.title,
                                price: _editedMovie.price,
                                description: _editedMovie.description,
                                imageUrl: value,
                                id: _editedMovie.id,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
      ),
                      ),
    );
  } 
}
