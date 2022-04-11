import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;
  const CastingCards({ Key? key,required this.movieId }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final movieProvider=Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: movieProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot){

        if (!snapshot.hasData){
        return Container(
          constraints: BoxConstraints(maxWidth: 150),
          height: 180,
          child: CupertinoActivityIndicator(),
        );
        }
        final List<Cast> cast =snapshot.data!;

         return Container(
           width: double.infinity,
           height: 180,
           //color: Colors.red,
           child: ListView.builder(
             itemCount: cast.length,
             scrollDirection: Axis.horizontal,
             itemBuilder: (BuildContext context, int index){
               return _CastCard(cast: cast[index],);
             },
           ),
         );
      });


  }
}

class _CastCard extends StatelessWidget {
  final Cast cast;
  const _CastCard({ Key? key,required  this.cast }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 100,
      height: 130,
      //color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg') ,
              //image: NetworkImage('https://via.placeholder.com/300x400'),
              image: NetworkImage(cast.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5,),
          Text(
            cast.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}