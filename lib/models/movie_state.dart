import 'package:movieapi/models/movie.dart';

class MovieState {
  final String apiPath;
  final int page;
  final bool isLoad;
  final String errMessage;
  final List<Movie> movies;
  final String searchText;
  final bool loadMore;

  MovieState(
      {required this.apiPath,
      required this.page,
      required this.searchText,
      required this.errMessage,
      required this.movies,
      required this.isLoad,
      required this.loadMore});

  MovieState copyWith(
      {required MovieState movieState,
      String? apiPath,
      int? page,
      bool? isLoad,
      String? errMessage,
      List<Movie>? movies,
      String? searchText,
      bool? loadMore}) {
    return MovieState(
        apiPath: apiPath ?? movieState.apiPath,
        page: page ?? movieState.page,
        searchText: searchText ?? movieState.searchText,
        errMessage: errMessage ?? movieState.errMessage,
        movies: movies ?? movieState.movies,
        isLoad: isLoad ?? movieState.isLoad,
        loadMore: loadMore ?? movieState.loadMore);
  }
}
