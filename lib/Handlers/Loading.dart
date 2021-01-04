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
          Image.asset('images/clapperboard.png',width: 50,height: 50,),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Cooking movies for you :)!",
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