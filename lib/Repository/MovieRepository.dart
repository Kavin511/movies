import 'package:movies/ApiKey.dart';
import 'package:movies/Model/Model.dart';
import 'package:movies/Networking/MoviesapiHelper.dart';

class MovieRepository {
  final String _apiKey = ApiKey.api_key;
  ApiHelper _helper = ApiHelper();

  Future<List<Movie>> fetchMovieList(String s) async {
    if (s.length >= 2) {
      s = "&with_genres=" + s;
    } else {
      s = "";
    }
    final response = await _helper.get(
        "discover/movie?api_key=$_apiKey&sort_by=popularity.desc&page=1&primary_release_year=2020${s}");
    return MoviesResponse.fromJson(response).results;
  }

  Future<List<Movie>> fetchTopRatedMovie() async {
    final response =
        await _helper.get("movie/top_rated?api_key=$_apiKey&language=en-US");
    return MoviesResponse.fromJson(response).results;
  }

  Future<List<Movie>> fetchSearchMovieList(String s) async {
    final response = await _helper
        .get("search/movie?api_key=${ApiKey.api_key}&language=en-US&query=$s");
    return MoviesResponse.fromJson(response).results;
  }
}
// movie/{movie_id}?api_key=<<api_key>>&language=en-US
