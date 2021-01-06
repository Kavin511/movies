import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies/Handlers/Error_occurred.dart';
import 'package:movies/Handlers/List/List_movie.dart';
import 'package:movies/Handlers/Loading.dart';
import 'package:movies/Model/Model.dart';
import 'package:movies/Networking/Apiresponse.dart';
import 'package:movies/UI/Movie_detail.dart';
import 'package:movies/UI/MoviesSearch.dart';
import 'package:movies/blocs/MovieBloc.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  MovieBloc bloc;
  int selected_index;
  final List<String> _options = ['Action', 'Comedy', 'Horror', 'Drama'];
  Widget _buildChips() {
    List<Widget> chips = new List();
    for (int i = 0; i < _options.length; i++) {
      ChoiceChip choiceChip = new ChoiceChip(
        selected: selected_index == i,
        label: Text(
          _options[i].toString(),
          style: TextStyle(
              color: selected_index == i ? Colors.white : Colors.black87),
        ),
        elevation: 6,
        pressElevation: 3,
        backgroundColor: Colors.white,
        selectedColor: Colors.blueAccent,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              selected_index = i;
              if (i == 0) {
                bloc.fetchMovieList("28");
              } else if (i == 1) {
                bloc.fetchMovieList("35");
              } else if (i == 2) {
                bloc.fetchMovieList("27");
              } else if (i == 3) {
                bloc.fetchMovieList("18");
              }
            } else {
              selected_index =-1;
            }
          });
        },
      );
      chips.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: choiceChip,
      ));
    }
    return ListView(scrollDirection: Axis.horizontal, children: chips);
  }
  //  Widget _searchWidget() {
  //  return new  Row(
  //     children: [
  //       TextFormField(
  //         decoration: InputDecoration(
  //           prefixIcon: Icon(Icons.search),
  //           hintText: 'Enter movie',
  //           border: OutlineInputBorder(),
  //           filled: true,
  //         ),
  //
  //       ),
  //     ],
  //   );
  // }
  Widget appBarTitle = new Text('Movies',style: TextStyle(
    color: Colors.black87
  ),);

  @override
  void initState() {
    super.initState();
    bloc = MovieBloc();
  }

  Icon actionIcon = new Icon(CupertinoIcons.search);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar,
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: new Text('Movies',style: TextStyle(
            color: Colors.black87
        )),
        actions: [
          IconButton(
            icon: Icon(Icons.search,color: Colors.black87,),
            onPressed: (){
              Navigator.pushNamed(context, '/search');
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert,color: Colors.black87,),
            itemBuilder: (BuildContext context)=><PopupMenuEntry>[
              PopupMenuItem(
                child: ListTile(
                  trailing: Icon(CupertinoIcons.heart_fill,color: Colors.redAccent,),
                  title: Text('Wish Lists'),
                  onTap: () {
                    Navigator.pushNamed(context, '/wish');
                    dispose();
                  },
                ),
              ),
            ],
          )
          // PopupMenuButton<String>(
          //   onSelected: handleClick,
          //   itemBuilder: (BuildContext context) {
          //     return {'Wish lists'}.map((String choice) {
          //       return PopupMenuItem<String>(
          //         value: choice,
          //         child: Text(choice),
          //       );
          //     }).toList();
          //   },
          // ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return bloc.fetchMovieList("");
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
                  return Column(
                    children: [
                      Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: _buildChips(),
                          // child: Column(
                          //   children: [
                          //     // TextFormField(
                          //     //   decoration: InputDecoration(
                          //     //     prefixIcon: Icon(Icons.search),
                          //     //     hintText: 'Enter movie',
                          //     //     border: OutlineInputBorder(),
                          //     //     filled: true,
                          //     //   ),
                          //     //
                          //     // ),
                          //
                          //   ],
                          // )
                      ),
                      MovieList(movieList: snapshot.data.data),
                    ],
                  );
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
  void handleClick(String value) {
    switch (value) {
      case 'Wish lists':
        Navigator.pushNamed(context, '/wish');
    }
  }
}
