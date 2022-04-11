import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //se obtienen los argumentos dependiendo de quien lo llama
    //final String movie=ModalRoute.of(context)?.settings.arguments.toString()??'no-movie';
    //obtiene el argumento mandado y lo guarda en movie
    final Movie movie=ModalRoute.of(context)!.settings.arguments as Movie;//as movie, no lo convierte en movie, sino q lo trata como tal
    print(movie.fullBackdropPath.toString());
    return    Scaffold(
      body: CustomScrollView(
        slivers: [
           _CustomAppBar(movie: movie,),
          //const _Overview(),No se puede porq no es un sliver
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterTitle(movie: movie,),
              _Overview(movie: movie,),
              _Overview(movie: movie,),
              _Overview(movie: movie,),
              _Overview(movie: movie,),
              CastingCards(movieId: movie.id,),

            ]
              
          )),
        ],
        
      )
    );
  }
}


class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
        backgroundColor: Colors.green,
        expandedHeight: 200,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            color: Colors.black12,
            child:  Text(
              movie.title,
              style: const TextStyle(fontSize: 16),
              ),
          ),
          background: FadeInImage(
            placeholder: const AssetImage('assets/loading.gif'), 
            image: NetworkImage(movie.fullBackdropPath),
            fit: BoxFit.cover,
            ),
        ),
    );
  }
}

class _PosterTitle extends StatelessWidget {
  final Movie movie; 
  const _PosterTitle({Key? key,required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    print('details - ${movie.heroId}');
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,//el mismo tag del cardswiper
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
              ),
            ),
          ),
          const SizedBox(width: 20,),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width-190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                Text(movie.title, style: Theme.of(context).textTheme.headline4,overflow: TextOverflow.ellipsis,maxLines: 2,),
                Text(movie.originalTitle, style: Theme.of(context).textTheme.subtitle2,overflow: TextOverflow.ellipsis,maxLines: 1,),
          
                Row(
                  children: [
                    const Icon(Icons.star_outline, size: 15, color: Colors.blueGrey,),
                    const SizedBox(width: 5,),
                    Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.caption,)
                  ],
                ),
              ],
          
            ),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;
  const _Overview({ Key? key, required this.movie }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child:  
              //Text('Proident pariatur sint adipisicing proident est dolor mollit officia ea fugiat reprehenderit laborum. Sunt sunt nostrud cupidatat eiusmod ex mollit ea qui laboris enim amet nisi ex occaecat. Tempor fugiat ipsum sunt ullamco excepteur tempor proident ex ut. Eiusmod dolor aute ad minim ipsum. Id amet ea est sunt ut ad minim sint mollit commodo. In exercitation exercitation ut nulla reprehenderit veniam laborum id qui nostrud irure reprehenderit minim. Eiusmod nostrud adipisicing consequat cupidatat in mollit sint elit cupidatat amet aliqua deserunt ut.Eiusmod sit aute ut elit anim elit aute culpa magna eiusmod sint.',
              Text(movie.overview,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.subtitle2,
      ),
      
    );
  }
}