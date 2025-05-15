import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/movie.dart';

class CustomSearchDelegate extends SearchDelegate {
  final String _apiKey = '09bc3f9416e1dc316dbfff080ffe843d';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildMovieResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text('Type to search'));
    } else {
      return _buildMovieResults();
    }
  }

  Widget _buildMovieResults() {
    return FutureBuilder<List<Movie>>(
      future: _getMovies(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data!.isEmpty) {
          return Center(child: Text('No results found'));
        } else {
          final movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading:movie.poster_path.isNotEmpty
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w92${movie.poster_path}',
                        fit: BoxFit.cover,
                        
                      )
                    : Icon(Icons.movie),
                  title: Text(movie.title),
                ),
              );
            },
          );
        }
      },
    );
  }

  Future<List<Movie>> _getMovies(String query) async {
    final encodedQuery = Uri.encodeQueryComponent(query);
    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$_apiKey&language=en-US&query=$encodedQuery&page=1&include_adult=false');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }
}
