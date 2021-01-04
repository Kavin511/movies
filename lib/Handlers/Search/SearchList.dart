import 'package:flutter/material.dart';
import 'package:movies/Model/Model.dart';
import 'MovieItem.dart';

class MovieListData extends StatelessWidget {
  final List<Movie> movieList;
  final Function itemClick;

  MovieListData({this.movieList, this.itemClick});

  @override
  Widget build(context) {
    return movieList.length <= 0
        ? Center(
            child: Text(
              "No results found",
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: this.movieList.length,
            shrinkWrap: true,
            padding: EdgeInsets.all(8.0),
            physics:
                const BouncingScrollPhysics(parent: ClampingScrollPhysics()),
            itemBuilder: (BuildContext context, int index) {
              return MovieItem(movie: movieList[index]);
            });
  }
}
