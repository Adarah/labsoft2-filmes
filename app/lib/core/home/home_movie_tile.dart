import 'package:app/models/movie.dart';
import 'package:app/widgets/movie_tile.dart';
import 'package:flutter/material.dart';

class HomeMovieTile extends StatelessWidget {
  final Movie movie;

  const HomeMovieTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MovieTile(
      movie: movie,
      children: [
        Text('FILME | ${movie.releaseYear}'),
        Text('${movie.score} (IMDB)'),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: movie.streamingServices
              .expand((svc) => [
                    SizedBox(
                      width: 100.0,
                      height: 20,
                      child: svc.logo,
                    ),
                  ])
              .toList(),
        ),
      ],
    );
  }
}
