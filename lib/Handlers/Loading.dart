import 'package:flutter/material.dart';

class Loading extends StatelessWidget
{
  final String loadingMessage;

  Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.local_movies_outlined,
            size: 50.0,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Almost done!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  CircularProgressIndicator(
                    strokeWidth: 1,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}