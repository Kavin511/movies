import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movies/Model/Model.dart';
import 'package:movies/UI/Movie_detail.dart';
class Movie_Card extends StatelessWidget {
  final Movie movieList;
  final Size size;

  const Movie_Card(this.movieList, this.size);

  @override
  Widget build(BuildContext context) {
    // const Size widget_size=context.size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: OpenContainer(
          closedElevation: 10,
          closedBuilder: (context, action) => Container(
              child: Stack(
            children: [
              Container(
                height: size.height,
                child: new Image.network(
                  "https://image.tmdb.org/t/p/w342${movieList.posterPath}",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  width: size.width * .80,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      // flex: 1,

                      child: RichText(
                        // textAlign: TextAlign.center,
                        text: TextSpan(
                            text: movieList.title,
                            style: TextStyle(
                                fontFamily: 'roboto',
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )),
            ],
          )),
          openBuilder: (context, action) => MovieDetail(
            movie: this.movieList.id,
          ),
        ),
      ),
    );
  }

  Column buildMovie(BuildContext context) {
    return Column(
      children: [
        // Expanded(
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Container(
        //       decoration: BoxDecoration(
        //         // color: Colors.blueGrey,
        //         borderRadius: BorderRadius.circular(20.0),
        //         // boxShadow: [
        //         //   BoxShadow(
        //         //     // offset: Offset(0, 4),
        //         //     blurRadius: 4,
        //         //     spreadRadius: 1,
        //         //     color: Colors.white
        //         //     // offset: Offset(0, )
        //         //   )
        //         // ],
        //         image: DecorationImage(
        //             fit: BoxFit.fill,
        //             image: NetworkImage(
        //                 "https://image.tmdb.org/t/p/w342${movieList.posterPath}")),
        //       ),
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            movieList.title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
