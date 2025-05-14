class Movie {
  final String title;
  final String backdrop_path;
  final String poster_path;

  Movie({
    required this.title,
    required this.backdrop_path,
    required this.poster_path,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      backdrop_path: 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}',
      poster_path: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
    );
  }
}
