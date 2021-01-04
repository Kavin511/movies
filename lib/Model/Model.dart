class MoviesResponse {
  int totalResults;
  int page, totalPages;
  List<Movie> results;

  MoviesResponse({this.page, this.totalResults, this.totalPages, this.results});

  MoviesResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    if (json['results'] != null) {
      results = new List<Movie>();
      json['results'].forEach((v) {
        results.add(new Movie.fromJson(v));
      });
    }
  }
}

class Movie {
  int id;
  var voteAverag;
  String title;
  String posterPath;
  String overView;
  String releaseDate;
  String year;
  String backDropPath;
  String original_title;
  String original_language;
  String status;
  // Genre genere;
  String tagline;
  int runtime;

  Movie({
    this.id,
    this.title,
    this.overView,
    this.releaseDate,
    this.posterPath,
    this.year,
    this.backDropPath,
    this.original_title,
    this.original_language,
    this.status,
    // this.genere,
    this.tagline,
    this.runtime,
  });
  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voteAverag = json['vote_average'];
    title = json['title'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    overView = json['overview'];
    backDropPath = json['backdrop_path'];
    original_title = json['original_title'];
    original_language = json['original_language'];
    status = json['status'];
    // genere = Genre.fromJson(json['genres']);
    tagline = json['tagline'];
    runtime = json['runtime'];
  }
}
// class Genre {
//   String id;
//   String name;
//
//   Genre({this.id, this.name});
//
//   factory Genre.fromJson(Map<String, dynamic> json) =>
//       Genre(name: json["name"], id: json['id']);
//
//   Map<String, dynamic> toJson() => {"name": name, "id": id};
// }
