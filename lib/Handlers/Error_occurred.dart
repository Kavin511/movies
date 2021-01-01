import 'package:flutter/material.dart';
import 'package:movies/blocs/MovieBloc.dart';

class Error_message extends StatelessWidget {
  String errorMessage;
  Function() onRetryPressed;
  MovieBloc _bloc = new MovieBloc();

  Error_message({
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Error occurred",
              textAlign: TextAlign.center,
            ),
            OutlinedButton(
              child: Text("Retry"),
              onPressed: () =>
              {
                _bloc.fetchMovieList(""),
              },
            )
          ],
        ),
      ),
    );
  }
}