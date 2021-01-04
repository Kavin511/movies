import 'dart:async';
import 'package:movies/Model/Model.dart';
import 'package:movies/Networking/Apiresponse.dart';
import 'package:movies/Repository/SearchRepository.dart';
class SearchBloc
{
  SearchRepository _searchRepository;
  StreamController _movieListController;
  StreamSink<ApiResponse<List<Movie>>> get movieListSink =>
      _movieListController.sink;
  Stream<ApiResponse<List<Movie>>> get movieListStream =>
      _movieListController.stream;
  MovieBloc() {
    _movieListController = StreamController<ApiResponse<List<Movie>>>();
    _searchRepository = SearchRepository();
    fetchMovieList("");
  }
  fetchMovieList(String s) async {
    movieListSink.add(ApiResponse.loading('Fetching Movies'));
    try {
      List<Movie> movies = await _searchRepository.fetchSearchMovieList(s);
      movieListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      movieListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }
  dispose() {
    _movieListController?.close();
  }
}