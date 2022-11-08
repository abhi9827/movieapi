import 'package:movieapi/api.dart';
import 'package:movieapi/models/movie_state.dart';
import 'package:movieapi/service/movie_service.dart';

import 'package:riverpod/riverpod.dart';

final movieProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) =>
    MovieProvider(MovieState(
        apiPath: Api.popularMovieApi,
        page: 1,
        searchText: '',
        errMessage: '',
        movies: [],
        isLoad: false,
        loadMore: false)));

class MovieProvider extends StateNotifier<MovieState> {
  MovieProvider(super.state) {
    getMovieData();
  }

  Future<void> getMovieData() async {
    try {
      state = state.copyWith(isLoad: true, movieState: state);
      final response = await MovieService.getMovieByCategory(
          apiPath: state.apiPath, page: state.page);
      state =
          state.copyWith(isLoad: false, movieState: state, movies: response);
    } catch (err) {}
  }

  Future<void> getMovieByCategory(String apiPath) async {
    state = state.copyWith(movieState: state, movies: [], apiPath: apiPath);
    getMovieData();
  }
}
