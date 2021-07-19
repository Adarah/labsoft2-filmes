import 'package:app/core/movie_details/movie_details_screen.dart';
import 'package:app/models/movie.dart';
import 'package:flutter/material.dart';

class MovieDetailsPage extends Page {
  final Movie movie;

  MovieDetailsPage({Key? key, required this.movie})
      : super(key: const ValueKey('MovieDetailsPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => MovieDetailsScreen(
        movie: movie,
      ),
    );
  }
}
