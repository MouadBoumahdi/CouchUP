class Movie {
  final String backdrop_path;
  final String title;
  final String overview;
  final String popularity;
  final String poster_path;
  final String release_date;
  final double vote_average;
  final int vote_count;

  Movie({
    required this.backdrop_path,
    required this.title,
    required this.overview,
    required this.popularity,
    required this.poster_path,
    required this.release_date,
    required this.vote_average,
    required this.vote_count
  });
}