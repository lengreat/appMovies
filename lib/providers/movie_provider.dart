import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:movies_app/helpers/debouncer.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/models/search_response.dart';
//import 'package:movies_app/models/now_playing_response.dart';


class MoviesProvider extends ChangeNotifier {
  String _api_key='e8d4e0b3a870d842365ec7f1dbce0368';
  String _base_url='api.themoviedb.org';
  String _languaje='es-ES';
  List<Movie> onDisplayMovie = [];

  Map<int, List<Cast>> movieCast={};

  //implementacion de debouncer
  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream=> this._suggestionStreamController.stream;

  MoviesProvider(){
    print('inicializado provider 1');
    getOnDisplayMovies();
  }
  getMovies(){
      return onDisplayMovie;
  }

  Future<String> _getJsonData( String endpoint, [int page = 1] ) async {
    final url = Uri.https( _base_url, endpoint, {
      'api_key': _api_key,
      'language': _languaje,
      'page': '$page'
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async{
    /*var url =
      //Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
      Uri.https(_base_url, '/3/movie/now_playing',
       {'api_key': _api_key,
        'languaje': _languaje,
        'page': '1',
       }
       );
    //print('getOnDisplayMOvies');
    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);*/
    //----------------
    //print (response.body);
    //print(''' ''');
    //final Map<String, dynamic> decodeData=convert.json.decode(response.body);
    //print(decodeData['results'][0]['title']);//se imprime mediante las respuesta mapeada
    //--------------------
    // final nowPlayingResponse=NowPlayingResponse.fromJson(response.body);
    final jsonData = await this._getJsonData('/3/movie/now_playing');//obtenog la respuesta en forma de mapa
    final nowPlayingResponse=NowPlayingResponse.fromJson(jsonData);//obtengo la respuesta en forma de clase

    //print(nowPlayingResponse.results[0].title);//se imprime mediante la clase a partir de la respuesta mapeada
    onDisplayMovie=nowPlayingResponse.results;//guardo el arreglo de peliculas
    notifyListeners();

  }

  Future<List<Cast>> getMovieCast(int movieId) async{
    if(movieCast.containsKey(movieId)) return movieCast[movieId]!;//Si fue creada un constantkey(int) es decir ya existe, entonces returna el guardado en menmoria y no vuelve a cargar
      print('pidiendo info al servidor....');

      final jsonData= await this._getJsonData('/3/movie/${movieId}/credits');
      print(jsonData);
      final creditsResponse = CreditsResponse.fromJson(jsonData);
      // print(creditsResponse.cast[0].character);
      movieCast[movieId]=creditsResponse.cast;//guardo solo el cast, solo lo utilizo para el constainkey
      return creditsResponse.cast;

  }


 Future<List<Movie>>   searchMovies(String query)async{
  final url = Uri.https( _base_url, '3/search/movie', {
      'api_key': _api_key,
      'language': _languaje,
      'query': query
    });
    final response=await http.get(url);
    final searchResponse=SearchResponse.fromJson(response.body);
    return searchResponse.results;
 }
 
 void getSuggestionByQuery(String searchTerm){
   debouncer.value='';
   debouncer.onValue=(value) async {//value es searchTerm
     //print('Tenemos valor a buscar: ${value}');
     final results=await this.searchMovies(value);
     this._suggestionStreamController.add(results);
   };
   final timer=Timer.periodic(
     Duration(milliseconds: 200),
      (_) {debouncer.value=searchTerm; }
   );
   Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel());
 }

}

