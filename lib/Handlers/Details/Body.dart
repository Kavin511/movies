import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:movies/Language.dart';
import 'package:movies/Localstorage/LocalStorage.dart';
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
  LanguageLocal languageLocal = LanguageLocal();
  final WishListStorage wishListStorage = new WishListStorage();

  _BodyState(this.movieDetails);

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    bool wishListed = false;
    List key = wishListStorage.getAllKeys();
    Size size = MediaQuery.of(context).size;
    ImageProvider image1 = movieDetails.backDropPath != null
        ? NetworkImage(imageUrl + movieDetails.backDropPath)
        : AssetImage("images/clapperboard.png");
    Icon wishIcon = new Icon(
        isPressed ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
        color: Colors.redAccent,
        semanticLabel: "Wish list");
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
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        bottomLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0)),
                    image:
                        new DecorationImage(image: image1, fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
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
                            new IconButton(
                              icon: wishIcon,
                              enableFeedback: true,
                              splashColor: Colors.black12,
                              iconSize: 24,
                              onPressed: () {
                                setState(() {
                                  isPressed = true;
                                });
                                final info = json.encode({
                                  "id": movieDetails.id,
                                  "voteAverag": movieDetails.voteAverag,
                                  "title": movieDetails.title,
                                  "posterPath": movieDetails.posterPath,
                                  "overView": movieDetails.overView,
                                  "releaseDate": movieDetails.releaseDate,
                                  "year": movieDetails.year,
                                  "backDropPath": movieDetails.backDropPath,
                                  "original_title": movieDetails.original_title,
                                  "original_language":
                                      movieDetails.original_language,
                                  "status": movieDetails.status,
                                  "tagline": movieDetails.tagline,
                                  "runtime": movieDetails.runtime,
                                });
                                add(info, movieDetails.id);
                              },
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            RichText(
                              softWrap: true,
                              text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: "Wish list",
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
                              softWrap: true,
                              text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: languageLocal
                                            .getDisplayLanguage(
                                                '${movieDetails.original_language}')
                                            .toString(),
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
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 5, left: 10, right: 10),
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
                    Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.date_range_rounded),
                      ),
                      Text(movieDetails.releaseDate),
                    ]),
                    SizedBox(
                      width: 5,
                    ),
                    Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.movie_outlined),
                      ),
                      Text(movieDetails.status.toString()),
                    ]),
                    SizedBox(
                      width: 5,
                    ),
                    Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.timer),
                      ),
                      Text(movieDetails.runtime.toString() + " mins"),
                    ]),
                  ],
                ),
              ),
            ),
          ),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Text(
                        'Plot Summary',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Container(
                      child: Text(
                        // movieDetails.overView > 0
                        //     ?
                        movieDetails.overView.toString(),
                        // : "This movie plot is not available :(",
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void add(String info, int id) {
    List movieList = wishListStorage.getWishList() != null
        ? wishListStorage.getWishList()
        : [];
    int count = 0;
    for (int i = 0; i < movieList.length; i++) {
      Map<String, dynamic> info = json.decode(movieList[i]);
      if (id != info['id']) {
        count++;
      }
    }
    final snackBar = SnackBar(content: Text('Wish listed successfully!'));
    Scaffold.of(context).showSnackBar(snackBar);
    if (movieList.length == count) {
      movieList.add(info);
      debugPrint('List' + movieList.toString());
      wishListStorage.addWishList(movieList);
      debugPrint("added success");
    }
  }
}
