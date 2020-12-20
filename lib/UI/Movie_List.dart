import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies/Model/Model.dart';
import 'package:movies/Networking/Apiresponse.dart';
import 'package:movies/blocs/MovieBloc.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  MovieBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = MovieBloc();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          CupertinoIcons.infinite,
          color: Colors.white,
        ),
        title: Text("Movies Infinity"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: (){
          return bloc.fetchMovieList();
        },
        child: StreamBuilder<ApiResponse<List<Movie>>>(
          stream: bloc.movieListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(
                    loadingMessage: snapshot.data.message,
                  );
                  break;
                case Status.COMPLETED:
                  return MovieList(movieList: snapshot.data.data);
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
              onPressed: () => {
                _bloc.fetchMovieList(),
              },
            )
          ],
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movieList;

  // final List<Movie> TopratedmovieList=movieBloc;
  const MovieList({Key key, this.movieList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular movies",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            height: 230,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () {},
                    child: Card(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w342${movieList[index].posterPath}',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top rated',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),
          // Container(
          //   height: 230,
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: movieList.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Padding(
          //         padding: const EdgeInsets.all(5),
          //         child: InkWell(
          //           onTap: () {},
          //           child: Card(
          //             child: ClipRRect(
          //               borderRadius: BorderRadius.circular(5),
          //               child: Image.network(
          //                 'https://image.tmdb.org/t/p/w342${movieList[index].posterPath}',
          //                 fit: BoxFit.fill,
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
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
                      softWrap: true,
                    ),
                  ),
                  CircularProgressIndicator(strokeWidth: 1,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
