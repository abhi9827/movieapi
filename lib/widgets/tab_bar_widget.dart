import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieapi/provider/movie_provider.dart';
import 'package:riverpod/riverpod.dart';

class TabBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final movieData = ref.watch(movieProvider);
      if (movieData.isLoad) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Container(
          child: GridView.builder(
              itemCount: movieData.movies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 2 / 3),
              itemBuilder: (context, index) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(movieData.movies[index].poster_path));
              }),
        );
      }
    });
  }
}
