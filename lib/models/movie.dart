class Movie {
  final String title;
  final String overview;
  final String poster_path;
  final int id;
  final String vote_average;
  final String release_date;

  Movie(
      {required this.poster_path,
      required this.id,
      required this.vote_average,
      required this.overview,
      required this.title,
      required this.release_date});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        poster_path:
            'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${json['poster_path']}',
        id: json['id'],
        vote_average: '${json['vote_average']}',
        overview: json['overview'],
        title: json['title'],
        release_date: json['release_date']);
  }
}
