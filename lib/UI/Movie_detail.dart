import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/C%20files/AndroidStudioProjects/movies/lib/Handlers/Details/Detail_movie.dart';
import 'package:movies/Handlers/Error_occurred.dart';
import 'package:movies/Handlers/Loading.dart';
import 'package:movies/Model/Model.dart';
import 'package:movies/Networking/Apiresponse.dart';
import 'package:movies/Repository/MoviedetailRepository.dart';
import 'package:movies/blocs/MovieDetailBloc.dart';

class MovieDetail extends StatefulWidget {
  Movie movie;

  MovieDetail({this.movie});

  @override
  _MovieDetailState createState() => _MovieDetailState(movie: movie);
}

class _MovieDetailState extends State<MovieDetail> {
  MovieDetailBloc movieDetailBloc;
  Movie movie;
  MovieDetailRepository movieDetailRepository = new MovieDetailRepository();
  Movie detail = new Movie();
  _MovieDetailState({this.movie});

  @override
  void initState() {
    super.initState();
    movieDetailBloc = MovieDetailBloc(movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      extendBodyBehindAppBar: false,
      body: RefreshIndicator(
        onRefresh: () {
          return movieDetailBloc.fetchMovieDetail(movie.id);
        },
        child: StreamBuilder<ApiResponse<Movie>>(
          stream: movieDetailBloc.movieDetailStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(
                    loadingMessage: snapshot.data.message,
                  );
                  break;
                case Status.COMPLETED:
                  return DetailMovie(movieDetails: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error_message(
                    errorMessage: snapshot.data.message,
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}
