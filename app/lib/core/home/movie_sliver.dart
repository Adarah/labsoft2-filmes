import 'package:app/models/movie.dart';
import 'package:app/models/streaming_service.dart';
import 'package:app/viewmodels/linked_accounts_viewmodel.dart';
import 'package:app/widgets/something_went_wrong.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_movie_tile.dart';

class MovieSliver extends StatelessWidget {
  final Future<List<Movie>> moviesFuture;

  const MovieSliver({Key? key, required this.moviesFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: moviesFuture,
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: SomethingWentWrong(),
          );
        }
        if (snapshot.hasData) {
          final movies = snapshot.data!;
          final model = Provider.of<LinkedAccountsViewmodel>(context);
          final filteredMovies = _getMoviesFromEnabledServices(movies, model.enabledServices);
          return filteredMovies.length == 0
              ? SliverToBoxAdapter(
                  child: Text("You don't have any recommendations"),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      // This builder is called for each child.
                      // In this example, we just number each list item.
                      final pickedMovie = filteredMovies[index % filteredMovies.length];
                      return HomeMovieTile(movie: pickedMovie);
                    },
                  ),
                );
        }
        return SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  List<Movie> _getMoviesFromEnabledServices(
      List<Movie> movies, Iterable<StreamingService> enabledServices) {
    final _enabled = enabledServices.toSet();
    return movies.where((movie) {
      final services = movie.streamingServices.toSet();
      return services.intersection(_enabled).length != 0;
    }).toList();
  }
}
