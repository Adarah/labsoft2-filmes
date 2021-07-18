import 'package:app/core/reviews/movie_review_tile.dart';
import 'package:app/models/movie.dart';
import 'package:app/models/movie_repository.dart';
import 'package:app/viewmodels/auth_viewmodel.dart';
import 'package:app/widgets/app_scaffold.dart';
import 'package:app/widgets/something_went_wrong.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieRepo = context.read<MovieRepository>();
    final authModel = context.read<AuthViewmodel>();
    return AppScaffold(
      title: 'Avaliações',
      body: FutureBuilder<List<Movie>>(
        future: movieRepo.loadReviewedMovies(authModel.user!.id),
        builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasError) {
            return SomethingWentWrong();
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieReviewTile(movie: movies[index]);
            },
          );
        },
      ),
    );
  }
}
