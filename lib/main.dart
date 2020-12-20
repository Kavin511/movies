import 'package:flutter/material.dart';
import 'UI/Movie_List.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      theme: ThemeData.dark(
        // primarySwatch: Colors.blue,
      ),
      home: MovieScreen(),
    );
  }
}

