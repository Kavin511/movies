import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies/Handlers/List/Movie_card.dart';
import 'package:movies/Model/Model.dart';
import 'package:movies/UI/Movie_detail.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  MovieItem({this.movie});

  @override
  Widget build(BuildContext context) {
    ImageProvider image = movie.posterPath != null
        ? NetworkImage(
            'https://image.tmdb.org/t/p/w342' + movie.posterPath,
          )
        : AssetImage(
            "images/clapperboard.png",
          );
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetail(
              movie: movie.id,
            ),
          ),
        );
      },
      child: Material(
        elevation: 10,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: image,
                  radius: 40,
                  backgroundColor: Colors.white,
                ),
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        this.movie.title,
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                      Text(this.movie.releaseDate != null
                          ? "Release date :" + this.movie.releaseDate
                          : "No release date"),
                      Text(this.movie.tagline != null ? this.movie.tagline : '',maxLines: 2,)
                    ]),
              ),
            ],
          ),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white70,
              border: Border.all(color: Colors.grey, width: .1)),
        ),
      ),
    );
  }
}
