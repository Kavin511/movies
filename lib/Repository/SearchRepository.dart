import 'package:movies/ApiKey.dart';
import 'package:movies/Model/Model.dart';
import 'package:movies/Networking/MoviesapiHelper.dart';

class SearchRepository {
  final String _apiKey = ApiKey.api_key;
  ApiHelper _helper = ApiHelper();

  Future<List<Movie>> fetchSearchMovieList(String s) async {
    if (s.length > 0) {
      final response = await _helper
          .get("search/movie?api_key=${_apiKey}&language=en-US&query=${s}");
      return MoviesResponse.fromJson(response).results;
    }
  }
}
