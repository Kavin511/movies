import 'dart:async';
import 'package:movies/Model/Model.dart';
import 'package:movies/Networking/Apiresponse.dart';
import 'package:movies/Repository/MovieRepository.dart';
class MovieBloc
{
  MovieRepository _movieRepository;
  StreamController _movieListController;
  StreamController _movieSearchListController;
  StreamSink<ApiResponse<List<Movie>>> get movieListSink =>
      _movieListController.sink;
  StreamSink<ApiResponse<List<Movie>>> get movieSearchListSink =>
      _movieSearchListController.sink;

  Stream<ApiResponse<List<Movie>>> get movieListStream =>
      _movieListController.stream;
  Stream<ApiResponse<List<Movie>>> get movieSearchListStream =>
      _movieSearchListController.stream;
  MovieBloc() {
    _movieListController = StreamController<ApiResponse<List<Movie>>>();
    _movieSearchListController=StreamController<ApiResponse<List<Movie>>>();
    _movieRepository = MovieRepository();
    fetchMovieList("");
    fetchTopRatedMovie();
    fetchMovieList("");
  }
  fetchSearchMovieList(String s) async{
    movieSearchListSink.add(ApiResponse.loading('Fetching Movies'));
    try{
      List<Movie> movies = await _movieRepository.fetchSearchMovieList(s);
      movieSearchListSink.add(ApiResponse.completed(movies));
    }
    catch(e){
      movieSearchListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchMovieList(String s) async {
    movieListSink.add(ApiResponse.loading('Fetching Movies'));
    try {
      List<Movie> movies = await _movieRepository.fetchMovieList(s);
      movieListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      movieListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }
  dispose() {
    _movieListController?.close();
    _movieSearchListController.close();
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