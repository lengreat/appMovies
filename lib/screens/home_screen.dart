import 'package:flutter/material.dart';
import 'package:movies_app/providers/movie_popular_provider.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/search/search_delegate.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context,listen: true);//true va por defecto
    final moviesPopularProvider = Provider.of<MoviesPopularProvider>(context,listen: true);//true va por defecto
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Movies in line'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){
               showSearch(context: context, delegate: MovieSearchDelegate());
            }, 
            icon: const Icon(Icons.search_outlined))
        ],
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(movies:moviesProvider.getMovies()),
            MovieSlider(popularMovies: moviesPopularProvider.getMovies,
            onNextPage: (){
              //print('hola mundo');
              moviesPopularProvider.getOnDisplayMovies();//llama a la funcion para volver a ejecutar el http con page ++
            },),
          ],
        ),
      )
    );
  }
}