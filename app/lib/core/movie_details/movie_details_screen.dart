import 'package:app/core/reviews/movie_rating_bar.dart';
import 'package:app/models/movie.dart';
import 'package:app/viewmodels/navigator_viewmodel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigatorViewmodel>(
      builder: (context, model, child) => WillPopScope(
          child: child!,
          onWillPop: () {
            model.selectedMovie = null;
            return Future.value(true);
          }),
      child: Scaffold(
        appBar: AppBar(
          backwardsCompatibility: false,
          title: Text('Detalhes do filme'),
        ),
        body: SlidingUpPanel(
          body: Image.asset(
            movie.posterUrl,
            fit: BoxFit.cover,
          ),
          panel: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  movie.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3,
                  maxLines: 2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ano de lançamento: ${movie.releaseYear}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      'Duração: ${movie.duration}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      'Gêneros: ${movie.genres.join(', ')}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      'Plataformas: ${movie.streamingServices.join(', ')}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      'Nota (IMDB): ${movie.score}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Sua nota:'),
                    MovieRatingBar(enabled: true, onRatingUpdate: () {}),
                  ],
                )
              ],
            ),
          ),
          collapsed: Icon(Icons.arrow_upward),
          parallaxEnabled: true,
          backdropEnabled: true,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          minHeight: MediaQuery.of(context).size.height / 15,
          boxShadow: [BoxShadow(blurRadius: 6.0)],
        ),
      ),
    );
  }
}
