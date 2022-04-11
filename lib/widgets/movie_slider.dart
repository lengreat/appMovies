import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<MoviePopular>  popularMovies;
  final Function onNextPage;
  MovieSlider({ Key? key,
  required this.popularMovies, 
  required this.onNextPage,
   }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController=new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels>=scrollController.position.maxScrollExtent-500){
        //print('Obtener siguiente pagina');
        widget.onNextPage();//se llama al provider para recargar el scroll
      }
      //print(scrollController.position.pixels);
      //print(scrollController.position.maxScrollExtent);//posicion maxima de scroll
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final size1=MediaQuery.of(context).size.height;////Tamaño de pantalla completa, solo incluye altura de appbar
    final size2=AppBar().preferredSize.height;//Tamaño de appbar
    final size= (size1-size2);
    return Container(
      width: double.infinity,
      height: size*0.36,
      //color: Colors.amberAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Most view', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          Expanded(
            child: ListView.builder(//toma la altura del column padre, dara error ya que no hay altura del column, ya que es flexible
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              itemCount:widget.popularMovies.length,
              itemBuilder: (_, int index){
                final Pmovie=widget.popularMovies[index];
                print(Pmovie.fullPosterImg);
                return _MoviePoster(PopularMovie: Pmovie);
              }),
          )
        ],
      ),
      
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final MoviePopular PopularMovie;
  const _MoviePoster({Key? key,required  this.PopularMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PopularMovie.heroId='slider-${PopularMovie.id}';
    return Container(
      width: 117,//ancho de poster
      height: double.infinity,
      //color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: ()=>Navigator.pushNamed(context, 'details_slider',arguments:PopularMovie),
            child:  Hero(
              tag: PopularMovie.heroId!,
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(PopularMovie.fullPosterImg),
                width: double.infinity,
                height: 144,
                fit: BoxFit.cover,
                ),
            ),
          ),
          const SizedBox(height: 5,),
          if (PopularMovie.title!=null)
             Text(
              PopularMovie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
        ],
      ),
    );
  }
}