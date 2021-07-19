import 'package:app/core/home/home_movie_tile.dart';
import 'package:app/models/movie.dart';
import 'package:app/models/movie_repository.dart';
import 'package:app/widgets/something_went_wrong.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:provider/provider.dart';

class SearchResults extends StatefulWidget {
  final String searchTerm;

  const SearchResults({Key? key, required String searchTerm})
      : searchTerm = searchTerm,
        super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late final AsyncMemoizer<List<Movie>> _searchMemoizer;

  @override
  void initState() {
    super.initState();
    _searchMemoizer = AsyncMemoizer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        title: Text('Resultados da pesquisa'),
      ),
      body: Consumer<MovieRepository>(
        builder: (context, repo, child) => FutureBuilder(
          future: _searchMemoizer.runOnce(() => repo.search(widget.searchTerm)),
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if (snapshot.hasError) {
              return SomethingWentWrong();
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return snapshot.data!.length == 0
                ? Text('Nenhum filme encontrado')
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) =>
                        HomeMovieTile(movie: snapshot.data![index]),
                  );
          },
        ),
      ),
    );
  }
}
