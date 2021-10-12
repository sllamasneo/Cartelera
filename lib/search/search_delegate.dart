import 'package:flutter_peliculas/models/models.dart';
import 'package:flutter_peliculas/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => "Buscar peliculas";
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () => {close(context, null)}, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text("resultados");
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black38,
          size: 200,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return _emptyContainer();
    }
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionByQuery(query);

    return StreamBuilder(
        stream: moviesProvider.suggestionStream,
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) return _emptyContainer();
          final movies = snapshot.data;
          return ListView.builder(
              itemCount: movies!.length,
              itemBuilder: (_, int index) => _MovieItem(movies[index]));
        });
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: AssetImage('img/no-image.jpg'),
          image: NetworkImage(movie.fullPosterPathImg),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
    );
  }
}
