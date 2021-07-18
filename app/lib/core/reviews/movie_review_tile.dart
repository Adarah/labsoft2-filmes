import 'package:app/widgets/movie_tile.dart';
import 'package:app/models/movie.dart';
import 'package:flutter/material.dart';

import 'movie_rating_bar.dart';

class MovieReviewTile extends StatelessWidget {
  final Movie movie;

  const MovieReviewTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MovieTile(movie: movie, children: [MovieRatingBar(initialRating: 0, enabled: false)]);
  }
}
