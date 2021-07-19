import 'package:app/widgets/movie_tile.dart';
import 'package:flutter/material.dart';

import 'movie_rating_bar.dart';
import 'movie_reviews.dart';

class MovieReviewTile extends StatelessWidget {
  final MovieReview review;

  const MovieReviewTile({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MovieTile(movie: review.movie, children: [
      MovieRatingBar(initialRating: review.rating, enabled: false)
    ]);
  }
}
