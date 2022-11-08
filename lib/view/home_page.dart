import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieapi/api.dart';
import 'package:movieapi/models/movie_state.dart';
import 'package:movieapi/provider/movie_provider.dart';
import 'package:movieapi/widgets/tab_bar_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieState movieData = MovieState(
      apiPath: '',
      page: 0,
      searchText: '',
      errMessage: '',
      movies: [],
      isLoad: false,
      loadMore: false);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 110,
            flexibleSpace: Image.asset(
              'Assets/images/A.jpg',
              fit: BoxFit.cover,
            ),
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 52),
              child: Consumer(builder: (context, ref, child) {
                return TabBar(
                    onTap: (index) {
                      if (index == 0) {
                        ref
                            .read(movieProvider.notifier)
                            .getMovieByCategory(Api.popularMovieApi);
                      } else if (index == 1) {
                        ref
                            .read(movieProvider.notifier)
                            .getMovieByCategory(Api.topRatedMovieApi);
                      } else {
                        ref
                            .read(movieProvider.notifier)
                            .getMovieByCategory(Api.upcomingMovieApi);
                      }
                    },
                    indicator: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tabs: [
                      Tab(
                        text: 'Popular',
                      ),
                      Tab(
                        text: 'TopRated',
                      ),
                      Tab(
                        text: 'Upcoming',
                      ),
                    ]);
              }),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextFormField(
                  onFieldSubmitted: (val) {
                    setState(() {
                      movieData = movieData.copyWith(
                          movieState: movieData, searchText: val);
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Search Movie',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: OutlineInputBorder()),
                ),
              ),
              Text(movieData.searchText),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(children: [
                  TabBarWidget(),
                  TabBarWidget(),
                  TabBarWidget(),
                ]),
              ),
            ],
          )),
    );
  }
}
