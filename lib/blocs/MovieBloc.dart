import 'dart:async';
import 'package:movies/Model/Model.dart';
import 'package:movies/Networking/Apiresponse.dart';
import 'package:movies/Repository/MovieRepository.dart';
class MovieBloc
{
  MovieRepository _movieRepository;
  StreamController _movieListController;
  StreamSink<ApiResponse<List<Movie>>> get movieListSink =>
      _movieListController.sink;
  Stream<ApiResponse<List<Movie>>> get movieListStream =>
      _movieListController.stream;
  MovieBloc() {
    _movieListController = StreamController<ApiResponse<List<Movie>>>();
    _movieRepository = MovieRepository();
    fetchMovieList();
    fetchTopRatedMovie();
  }
  fetchMovieList() async {
    movieListSink.add(ApiResponse.loading('Fetching Movies'));
    try {
      List<Movie> movies = await _movieRepository.fetchMovieList();
      movieListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      movieListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }
  dispose() {
    _movieListController?.close();
  }

   fetchTopRatedMovie() async{
    movieListSink.add(ApiResponse.loading('Fetching movies'));
    try {
      List<Movie> movies = await _movieRepository.fetchTopRatedMovie();
      movieListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      movieListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
   }
}