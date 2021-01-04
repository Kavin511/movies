import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies/Localstorage/LocalStorage.dart';
import 'package:movies/UI/Movie_detail.dart';

class MovieWish extends StatefulWidget {
  @override
  _MovieWishState createState() => _MovieWishState();
}

class _MovieWishState extends State<MovieWish> {
  final WishListStorage wishListStorage = new WishListStorage();
   @override
  Widget build(BuildContext context) {
    List movieList = wishListStorage.getWishList() != null
        ? wishListStorage.getWishList()
        : [];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: RichText(
        text: TextSpan(
            text: 'Wish Lists',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      )),

        body:Container(
         child:movieList.length<=0?Center(
           child: Text(
             "No results found\n Add movies to your wish list",
             textAlign: TextAlign.center,
           ),
         ): ListView.builder(
            itemCount: movieList.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> info = json.decode(movieList[index]);
              ImageProvider image = info['backDropPath'] != null
                  ? NetworkImage(
                'https://image.tmdb.org/t/p/w342' + info['backDropPath'],
              )
                  : AssetImage(
                "images/clapperboard.png",
              );
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) async {
                  deleteWishItem(movieList[index]);
                },
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: AlignmentDirectional.centerStart,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: AlignmentDirectional.centerEnd,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Material(
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      isThreeLine: true,
                      leading: CircleAvatar(
                        backgroundImage: image,
                        radius: 35,
                        backgroundColor: Colors.white,
                      ),
                      title: Text(
                        info['title'],
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            info['releaseDate'] != null ? info['releaseDate'] : "",
                            maxLines: 2,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            info['tagline'].toString() != null
                                ? info['tagline'].toString()
                                : '',
                            maxLines: 2,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          deleteWishItem(movieList[index]);
                          setState(() {
                            movieList.removeAt(index);
                          });
                          // Navigator.of(context).pop();
                          // Navigator.pushNamed(context, '/wish');
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieDetail(movie: info['id']))),
                    ),
                  ),
                ),
              );
            },
          ),
        )
    );
  }

  deleteWishItem(movieList) {
    List movieStorage = wishListStorage.getWishList() != null
        ? wishListStorage.getWishList()
        : [];
    List finalList = [];
    for (int i = 0; i < movieStorage.length; i++) {
      if (movieStorage[i] != movieList) {
        {
          finalList.add(movieStorage[i]);
        }
      }
    }
    debugPrint('remove' + finalList.toString());
    wishListStorage.addWishList(finalList);
  }
}
