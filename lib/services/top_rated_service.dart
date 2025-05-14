import 'dart:convert';

import 'package:couchup/model/movie.dart';
import 'package:http/http.dart' as http;

class TopRatedService {
  final String _baseUrl = 'https://api.themoviedb.org/3/movie/top_rated';
  final String _apiKey = '09bc3f9416e1dc316dbfff080ffe843d';

  Future<List<Movie>> getTopRatedMovies() async {
   final response = await http.get(Uri.parse('$_baseUrl?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];

      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }
}