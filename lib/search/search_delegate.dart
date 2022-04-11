import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate{

@override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(onPressed: (){query='';}, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          close(context, null);
        },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('Hola mundo2');
  }

  Widget _EmtyContainer(){
    
      return  Container(
        child: const Center(
          child: Icon(
            Icons.movie_creation_outlined,
            color: Colors.black38,
            size: 100,
          ),
        ),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    if(query.isEmpty){
        return _EmtyContainer();
    }
    print('http request');
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    //debouncer
    moviesProvider.getSuggestionByQuery(query);

      return StreamBuilder(
        stream: moviesProvider.suggestionStream,
        //future: moviesProvider.searchMovies(query),
        builder: (_, AsyncSnapshot<List<Movie>> snapshot){
          if (!snapshot.hasData) return _EmtyContainer();

          final List<Movie> movies=snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, int index){
                return _MOvieItem(movie: movies[index],);
            },

          );

        },
      );
  }

}

class _MOvieItem extends StatelessWidget {
  final Movie movie;
  const _MOvieItem({Key? key,required  this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movie.heroId='search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: (){
        Navigator.pushNamed(context, 'details', arguments:movie);
      },
    );
  }
}