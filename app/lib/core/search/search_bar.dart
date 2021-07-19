import 'package:app/core/search/search_results.dart';
import 'package:app/models/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controller = new TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<MovieRepository>(context, listen: false);
    return TextField(
      controller: _controller,
      onSubmitted: (searchTerm) async {
        _controller.clear();
        Navigator.of(context).push(MaterialPageRoute(
          fullscreenDialog: true,
            builder: (context) => SearchResults(searchTerm: searchTerm)));
      },
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.go,
      decoration: InputDecoration(
        hintText: 'Busque aqui por um filme ou série',
        filled: true,
        fillColor: Colors.white,
        suffix: Icon(Icons.search),
      ),
    );
  }
}
