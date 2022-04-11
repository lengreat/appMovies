import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';


class MoviesPopularProvider extends ChangeNotifier {
  String _api_key='e8d4e0b3a870d842365ec7f1dbce0368';
  String _base_url='api.themoviedb.org';
  String _languaje='es-ES';
  List<MoviePopular> onDisplayMovie = [];
  int _popularPage=0;
  MoviesPopularProvider(){
    print('inicializando provider 2');
    getOnDisplayMovies();
  }
  get getMovies{
      return onDisplayMovie;
  }

  getOnDisplayMovies() async{
    _popularPage++;
    var url =
      Uri.https(_base_url, '/3/movie/popular',
       {'api_key': _api_key,
        'languaje': _languaje,
        'page': '$_popularPage',//va entrecomilla
       }
       );
    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    //----------------
     //----------------
    print (response.body);
    print(''' ff''');
    final Map<String, dynamic> decodeData=convert.json.decode(response.body);
    //print(decodeData['results'][0]);//se imprime mediante las respuesta mapeada
    //--------------------
    final popularResponse=PopularResponse.fromJson(response.body);

    //print(popularResponse.results[0].title);//se imprime mediante la clase a partir de la respuesta mapeada
    //onDisplayMovie=popularResponse.results;//guardo el arreglo de peliculas
    onDisplayMovie=[...onDisplayMovie, ...popularResponse.results];
    notifyListeners();
  }
}

