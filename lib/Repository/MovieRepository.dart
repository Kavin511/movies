import 'package:movies/Model/Model.dart';
import 'package:movies/Networking/MoviesapiHelper.dart';

class MovieRepository {
  final String _apiKey = "e8a281370261b694729d55d1c2246671";
  ApiHelper _helper = ApiHelper();

  Future<List<Movie>> fetchMovieList() async {
    final response = await _helper.get("movie/popular?api_key=$_apiKey");
    return MoviesResponse
        .fromJson(response)
        .results;
  }
  Future<List<Movie>> fetchTopRatedMovie() async {
    final response = await _helper.get(
        "/movie/top_rated?api_key=$_apiKey&language=en-US");
    return MoviesResponse
        .fromJson(response)
        .results;
  }

}