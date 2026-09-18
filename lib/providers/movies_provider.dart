import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class MovieProvider with ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '9dc27117b000e7e5acfb365fa957971a'; // <-- Actualiza esta línea[cite: 6]
  final String _language = 'es-MX';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> movieCast = {};

  MovieProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<void> getOnDisplayMovies() async {
    final url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final nowPlayingResponse =
          NowPlayingResponse.fromRawJson(response.body);

      onDisplayMovies = nowPlayingResponse.results;

      notifyListeners();
    } else {
      print('Error en películas en cartelera: ${response.statusCode}');
      print(response.body);
    }
  }

  Future<void> getPopularMovies() async {
    final url = Uri.https(_baseUrl, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final popularResponse =
          PopularResponse.fromRawJson(response.body);

      popularMovies = popularResponse.results;

      notifyListeners();
    } else {
      print('Error en películas populares: ${response.statusCode}');
      print(response.body);
    }
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) {
      return movieCast[movieId]!;
    }

    final url = Uri.https(_baseUrl, '3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final creditsResponse =
          CreditsResponse.fromRawJson(response.body);

      movieCast[movieId] = creditsResponse.cast;

      return creditsResponse.cast;
    }

    print('Error obteniendo reparto: ${response.statusCode}');
    print(response.body);

    return [];
  }
}