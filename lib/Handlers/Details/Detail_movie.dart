import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/Handlers/Details/Body.dart';
import 'package:movies/Model/Model.dart';

class DetailMovie extends StatelessWidget {
  final Movie movieDetails;
  const DetailMovie({Key key, this.movieDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(movieDetails.title.toString()),
      ),
      body: new  Body(movieDetails:this.movieDetails),
    );
  }
}
