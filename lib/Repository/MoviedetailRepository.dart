import 'package:movies/Model/Model.dart';
import 'package:movies/Networking/MoviesapiHelper.dart';

class MovieDetailRepository
{
  final String _apiKey="e8a281370261b694729d55d1c2246671";
  ApiHelper _helper=ApiHelper();
  Future<Movie> fetchMovieDetail(int selectedMovie) async{
    final response=await _helper.get("movie/$selectedMovie?api_key=$_apiKey");
    return Movie.fromJson(response);
  }
}