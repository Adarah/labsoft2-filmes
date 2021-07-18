import 'package:app/core/home/home_movie_tile.dart';
import 'package:app/models/movie.dart';
import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  final List<Movie> movies;

  const SearchResults({Key? key, required List<Movie> movies})
      : movies = movies,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
          title: Text('Resultados da pesquisa'),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) => HomeMovieTile(movie: movies[index]),
      ),
    );
  }
}
