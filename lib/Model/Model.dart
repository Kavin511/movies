class MoviesResponse{
  int totalResults;
  int page,totalPages;
  List<Movie> results;
  MoviesResponse({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results
});
  MoviesResponse.fromJson(Map<String ,dynamic> json)
  {
    page=json['page'];
    totalResults=json['total_results'];
    if(json['results']!=null)
      {
        results=new List<Movie>();
        json['results'].forEach((v){
          results.add(new Movie.fromJson(v));
        });
      }
  }
}
class Movie{
  int id;
  var voteAverage;
  String title;
  String posterPath;
  String overView;
  String releaseDate;
  String year;
  Movie(
  {
    this.id,
    this.title,
    this.voteAverage,
    this.overView,
    this.releaseDate,
    this.posterPath,
    this.year,
  });
  Movie.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    voteAverage=json['vote_average'];
    title=json['title'];
    posterPath=json['poster_path'];
    releaseDate=json['release_date'];
    overView=json['overview'];
    voteAverage=json['vote_average'];
  }
}