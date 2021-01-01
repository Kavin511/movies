import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:movies/Model/Model.dart';
import 'package:movies/UI/Movie_detail.dart';
class Body extends StatefulWidget {
  final Movie movieDetails;
  const Body({Key key, this.movieDetails}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(movieDetails);
}
class _BodyState extends State<Body> {
  final String imageUrl = 'https://image.tmdb.org/t/p/w342';
  final Movie movieDetails;
  // List<Genre> genreModel=[];
  _BodyState(this.movieDetails);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Container(
            height: size.height * .5,
            // color: Colors.white,
            child: Stack(
              children: [
                new Container(
                  width: size.width,
                  height: size.height * .5 - 25,
                  decoration: new BoxDecoration(
                    // color: Colors.white,
                    borderRadius:
                        new BorderRadius.only(bottomLeft: Radius.circular(50.0)),
                    image: new DecorationImage(
                        image: new NetworkImage(
                            imageUrl + movieDetails.backDropPath),
                        fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                        blurRadius:6,
                        color: Colors.black.withOpacity(.5),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: size.width * .9,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50.0),
                          topLeft: Radius.circular(50.0)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.black.withOpacity(.2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Icon(
                              Icons.star_rounded,
                              color: Colors.orange,
                              semanticLabel: "Ratings",
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: '${movieDetails.voteAverag}/10',
                                        style: TextStyle(
                                            fontFamily: 'Arvo',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))
                                  ]),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Icon(
                              Icons.bookmark_border,
                              color: Colors.black87,
                              semanticLabel: "Wish list",
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: 'Add to wish list',
                                        style: TextStyle(
                                            fontFamily: 'Arvo',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))
                                  ]),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Icon(
                              Icons.translate,
                              color: Colors.black87,
                              semanticLabel: "Language",
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: '${movieDetails.original_language}',
                                        style: TextStyle(
                                            fontFamily: 'Arvo',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))
                                  ]),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          new Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 5,left: 10,right: 10),
                      child: Text(
                        movieDetails.title,
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.white,
              elevation: 1,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.date_range_rounded),
                          ),
                          Text(movieDetails.releaseDate),
                        ]
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.movie_outlined),
                          ),
                          Text(movieDetails.status.toString()),
                        ]
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.timer),
                          ),
                          Text(movieDetails.runtime.toString()+" mins"),
                        ]
                    ),
                  ],
                ),
              ),
            ),
          ),
      // ListView.builder(
      //   scrollDirection: Axis.horizontal,
      //   itemCount: 10,
      //   itemBuilder: (BuildContext context,index)=>Container(
      //     alignment: Alignment.center,
      //     margin: EdgeInsets.only(left: 10),
      //     padding: EdgeInsets.symmetric(
      //       horizontal: 10,
      //       vertical: 10 / 4, // 5 padding top and bottom
      //     ),
      //     decoration: BoxDecoration(
      //       border: Border.all(color: Colors.black26),
      //       borderRadius: BorderRadius.circular(20),
      //     ),
      //     ListView.builder(
      //
      //     )
      //     Text(
      //         movieDetails.genere.id,
      //       style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),
      //     ),

      //   ),
      // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.white,
              elevation: 1,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      child: Text(
                        'Plot Summary',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Container(
                      child: Text(
                        movieDetails.overView.toString(),
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
