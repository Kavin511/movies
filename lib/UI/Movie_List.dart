import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies/Handlers/Error_occurred.dart';
import 'file:///D:/C%20files/AndroidStudioProjects/movies/lib/Handlers/List/List_movie.dart';
import 'package:movies/Handlers/Loading.dart';
import 'package:movies/Model/Model.dart';
import 'package:movies/Networking/Apiresponse.dart';
import 'package:movies/UI/Movie_detail.dart';
import 'package:movies/blocs/MovieBloc.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  MovieBloc bloc;
  int selected_index;
  final List<String> _options = ['Action', 'Comedy', 'Horror', 'Drama'];

  Widget _buildChips() {
    List<Widget> chips = new List();
    for (int i = 0; i < _options.length; i++) {
      ChoiceChip choiceChip = new ChoiceChip(
        selected: selected_index == i,
        label: Text(
          _options[i].toString(),
          style: TextStyle(
              color: selected_index == i ? Colors.white : Colors.black87),
        ),
        elevation: 6,
        pressElevation: 3,
        backgroundColor: Colors.white,
        selectedColor: Colors.blueAccent,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              selected_index = i;
              if (i == 0) {
                bloc.fetchMovieList("28");
              } else if (i == 1) {
                bloc.fetchMovieList("35");
              } else if (i == 2) {
                bloc.fetchMovieList("27");
              } else if (i == 3) {
                bloc.fetchMovieList("18");
              }
            } else {
              selected_index = i + 1;
            }
          });
        },
      );
      chips.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: choiceChip,
      ));
    }
    return ListView(scrollDirection: Axis.horizontal, children: chips);
  }

  @override
  void initState() {
    super.initState();
    bloc = MovieBloc();
  }

  final appBar = AppBar(
    leading: Icon(
      CupertinoIcons.film_fill,
      color: Colors.white,
    ),
    title: Text("Movies app"),
    actions: [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {},
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar,
      appBar: appBar,
      body: RefreshIndicator(
        onRefresh: () {
          return bloc.fetchMovieList("");
        },
        child: StreamBuilder<ApiResponse<List<Movie>>>(
          stream: bloc.movieListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(
                    loadingMessage: snapshot.data.message,
                  );
                  break;
                case Status.COMPLETED:
                  return Column(
                    children: [
                      Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: _buildChips()),
                      MovieList(movieList: snapshot.data.data),
                    ],
                  );
                  break;
                case Status.ERROR:
                  return Error_message(
                    errorMessage: snapshot.data.message,
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}
