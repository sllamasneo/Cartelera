import 'package:flutter/material.dart';
import 'package:flutter_peliculas/providers/movies_provider.dart';
import 'package:flutter_peliculas/search/search_delegate.dart';
import 'package:flutter_peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
  
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Center(
            child: Text('Peliculas en cine'),
          ),
          actions: [
            IconButton(
              onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: Icon(Icons.search_outlined),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //lista orisontal de peliculas

              CardSwiper(movies: moviesProvider.onDisplayMovies),
              //slider de peliculas
              MovieSlider(
                title:'Populares ',
                 movies: moviesProvider.popularMovies,
                 onNextPage:()=>moviesProvider.getPopularMovies()
              ),
            ],
          ),
        ));
  }
}
