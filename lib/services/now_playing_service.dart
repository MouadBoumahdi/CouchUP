import 'dart:convert';

import 'package:couchup/model/movie.dart';
import 'package:http/http.dart' as http;

class NowPlayingService {
  final String _baseUrl = 'https://api.themoviedb.org/3/movie/now_playing';
  final String _apiKey = '09bc3f9416e1dc316dbfff080ffe843d';

  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl?api_key=$_apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load popular movies');
    }
  }
}