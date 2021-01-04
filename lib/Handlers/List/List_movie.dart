import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/Handlers/List/Movie_card.dart';
import 'package:movies/Model/Model.dart';
import 'dart:math' as math;

class MovieList extends StatefulWidget {
  final List<Movie> movieList;

  // final List<Movie> TopratedmovieList=movieBloc;
  // bool popular_selected=true,action_selected=true,horror_selected=true,drama_selected=true,comedy_selected=true;
  const MovieList({Key key, this.movieList}) : super(key: key);
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> with TickerProviderStateMixin {
  PageController _pageController;
  int initialPage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.8,
      initialPage: initialPage,
    );
  }
  // Widget MovieSlider(int index) {
  //   // AnimatedBuilder(
  //   //   // animation: _pageController,
  //   //   builder: (BuildContext context, Widget child) {
  //   //     double value = 0;
  //   //     if (_pageController.position.haveDimensions) {
  //   //       value = (value * .038).clamp(-1, 1);
  //   //     }
  //   //     return Transform.rotate(
  //   //       angle: 3.14 * value,
  //   //       child:
  //         return Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
  //           child: Column(
  //             children: [
  //               Expanded(
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(50),
  //                       image: DecorationImage(
  //                           fit: BoxFit.fill,
  //                           image: NetworkImage(
  //                             'https://image.tmdb.org/t/p/w342${widget.movieList[index].posterPath}',
  //                           ))),
  //                 ),
  //               )
  //             ],
  //           ),
  //       //   ),
  //       // );
  //     // },
  //   );
  // }
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: AspectRatio(
          aspectRatio: .85,
          child: PageView.builder(
            controller: _pageController,
            physics: ClampingScrollPhysics(),
            onPageChanged: (value) {
              setState(() {
                initialPage = value;
              });
            },
            itemCount: widget.movieList.length,
            itemBuilder: (context, index) {
              return  Movie_Card(widget.movieList[index],size);
            },
          ),
        ));
  }


  Widget buildMovieSlider(int index,Size size) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        int value = 0;
        if (_pageController.position.haveDimensions) {
          value = (index - _pageController.page) as int;
          value = (value * .038).clamp(-1, -1);
        }
        return AnimatedOpacity(
          duration: Duration(milliseconds: 1000),
          opacity: initialPage == index ? 1 : .9,
          curve: Curves.bounceIn,
          child: Transform.rotate(
            angle: -math.pi / 12.0,
            child:  Movie_Card(widget.movieList[index],size),
          ),
        );
      },
    );
  }
}
