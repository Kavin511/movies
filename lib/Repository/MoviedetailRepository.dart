import 'package:movies/ApiKey.dart';
import 'package:movies/Model/Model.dart';
import 'package:movies/Networking/MoviesapiHelper.dart';

class MovieDetailRepository {
  final String _apiKey = ApiKey.api_key;
  ApiHelper _helper = ApiHelper();
  Future<Movie> fetchMovieDetail(int selectedMovie) async {
    final response = await _helper.get("movie/$selectedMovie?api_key=$_apiKey");
    return Movie.fromJson(response);
  }
}
