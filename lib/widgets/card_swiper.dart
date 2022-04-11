import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  const CardSwiper({ Key? key,
  required  this.movies }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Obtener tamano de pantalla con media query
    final size1=MediaQuery.of(context).size;////Tamaño de pantalla completa, solo incluye altura de appbar
    final size2=AppBar().preferredSize.height;//Tamaño de appbar
    final size3=MediaQuery.of(context).padding.top;//Tamaño de status bar, no se toma en cuenta su altura
    final size= size1.height-size2;

    if (this.movies.length==0){
      return Container(
        width: double.infinity,
        height: size*0.6,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      //height: ((size.height-size2)-size3)*0.96,//Ocupa toda la pantalla disponible
      height: size*0.6,
      //color: Colors.red,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.TINDER,
        itemWidth:(size1.width)*0.65,
        itemHeight: size*0.55,
        itemBuilder: (_, int index){
          final movie=movies[index];
          movie.heroId='swiper-${movie.id}';
          //print(movie.fullPosterImg);


          return GestureDetector(
            onTap: (){
              print(movie.heroId);
            Navigator.pushNamed(context, 'details', arguments: movie);
            },
            child: Hero(
              tag: movie.heroId!,//debe seer cualquier cosa pero unica
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder:const  AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.fill,
                  ),
              ),
            ),
          );
        },
      ),
    );
  }
}