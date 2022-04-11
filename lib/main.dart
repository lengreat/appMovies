import 'package:flutter/material.dart';
import 'package:movies_app/providers/movie_popular_provider.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/screens/detailss_slide.dart';
import 'package:movies_app/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>MoviesProvider(), lazy: false,),//lazy false, para que se llame tan pronto se inicia la aplicacion
        ChangeNotifierProvider(create: (_)=>MoviesPopularProvider(), lazy: false,),//lazy false, para que se llame tan pronto se inicia la aplicacion
      ],
      child:const  MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:  false,
      title: 'Movies',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'details': (_)=> const DetailsScreen(),
        'details_slider': (_)=> const DetailsSlide(),
      },
    
      theme: ThemeData.dark().copyWith(//Se crea una copia para realizar modificaciones
        appBarTheme:const  AppBarTheme(
          color: Colors.indigoAccent,
        )
      ),
    );
  }
}