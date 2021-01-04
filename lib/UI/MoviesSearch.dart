import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies/ApiKey.dart';
import 'package:movies/Handlers/Error_occurred.dart';
import 'package:movies/Handlers/List/List_movie.dart';
import 'package:movies/Handlers/Loading.dart';
import 'package:movies/Handlers/Search/SearchList.dart';
import 'package:movies/Model/Model.dart';
import 'package:movies/Networking/Apiresponse.dart';
import 'package:movies/Repository/SearchRepository.dart';
import 'package:movies/blocs/MovieBloc.dart';
import 'package:movies/blocs/SearchBloc.dart';
import 'package:http/http.dart' as http;

class MovieSearch extends StatefulWidget {
  @override
  _MovieSearchState createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  MovieBloc bloc;
  final searchTextController = new TextEditingController();
  String searchText = "";
  Future<Movie> futureAlbum;
  @override
  void initState() {
    super.initState();
    bloc = MovieBloc();
  }

  void itemClick(Movie item) {}

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
    searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search Movies'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Row(children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: searchTextController,
                    decoration:
                        InputDecoration(hintText: 'Enter keyword'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  tooltip: 'Search Movies',
                  onPressed: () {
                    setState(() {
                      searchText = searchTextController.text;
                      bloc.fetchSearchMovieList(searchText);
                    });
                  },
                ),
              ]),
              padding: EdgeInsets.all(10),
            ),
            if (searchText.length > 0)
              StreamBuilder<ApiResponse<List<Movie>>>(
                stream: bloc.movieSearchListStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        return Loading(
                          loadingMessage: snapshot.data.message,
                        );
                        break;
                      case Status.COMPLETED:
                        return Expanded(
                            child:MovieListData(movieList: snapshot.data.data),
                        );
                        break;
                      case Status.ERROR:
                        return Error_message(
                          errorMessage: snapshot.data.message,
                        );
                        break;
                    }
                  }
                  return Center(
                    child: Text('Error occurred ,try after some time:('),
                  );
                },
              ),
          ],
        ));
  }
}
