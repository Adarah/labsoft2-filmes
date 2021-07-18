import 'package:app/models/movie.dart';
import 'package:app/models/movie_repository.dart';
import 'package:app/models/streaming_service.dart';
import 'package:app/viewmodels/linked_accounts_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movie_tile.dart';

class MovieSliver extends StatelessWidget {
  final List<Movie> movies;

  const MovieSliver({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return movies.length == 0
        ? SliverToBoxAdapter(
            child: Text("You don't have any recommendations"),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // This builder is called for each child.
                // In this example, we just number each list item.
                final pickedMovie = movies[index % movies.length];
                return MovieTile(movie: pickedMovie);
              },
            ),
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
