import 'dart:async';

import 'package:peliculas/src/models/actor_mode.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeliculasProvider {
  String _apiKey = "ec145e0466b3598c14c1639747422dc7";
  String _url = "api.themoviedb.org";
  String _languaje = "es-ES";

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = [];

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStream() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri uri) async {
    final resp = await http.get(uri);
    final decodedData = json.decode(resp.body);
    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final uri = Uri.https(_url, "3/movie/now_playing",
        {'api_key': _apiKey, 'languaje': _languaje});

    return _procesarRespuesta(uri);
  }

  Future<List<Pelicula>> getPopular() async {
    if (_cargando) return [];

    _cargando = true;
    _popularesPage++;
    final uri = Uri.https(_url, "3/movie/popular", {
      'api_key': _apiKey,
      'languaje': _languaje,
      'page': _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(uri);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key': _apiKey,
      'languaje': _languaje,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = Actores.fromJsonList(decodedData['cast']);
    return cast.actores;
  }

  Future<List<Pelicula>> getBuscar(String query) async {
    final uri = Uri.https(_url, "3/search/movie",
        {'api_key': _apiKey, 'languaje': _languaje, 'query': query});

    return _procesarRespuesta(uri);
  }
}
