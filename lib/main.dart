import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies/Handlers/List/Movie_card.dart';
import 'package:movies/UI/Movie_detail.dart';
import 'UI/Movie_List.dart';
import 'UI/MoviesSearch.dart';
import 'WishList/MovieWishList.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => MovieScreen(),
      '/search': (context) => MovieSearch(),
      '/details': (context) => MovieDetail(),
      '/wish': (context) => MovieWish(),
    });
    // theme: ThemeData.light(),
    // home: Scaffold(
    //   backgroundColor: Colors.white,
    //   body: MovieScreen(),
    // ));
  }
}

