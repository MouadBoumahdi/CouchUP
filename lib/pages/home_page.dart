import 'package:flutter/material.dart';
import 'package:couchup/services/now_playing_service.dart';
import 'package:couchup/services/top_rated_service.dart';
import 'package:couchup/services/popular_service.dart';
import 'package:couchup/services/upcoming_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NowPlayingService _nowPlayingService = NowPlayingService();
  final TopRatedService _topRatedService = TopRatedService();
  final PopularService _popularService = PopularService();
  final UpcomingService _upcomingService = UpcomingService();
  List<dynamic> _movies = [];

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final now_playing_movies = await _nowPlayingService.getNowPlayingMovies();
    final top_rated_movies = await _topRatedService.getTopRatedMovies();
    final popular_movies = await _popularService.getPopularMovies();
    final upcoming_movies = await _upcomingService.getUpcomingMovies();
    setState(() {
      _movies = [...now_playing_movies, ...top_rated_movies, ...popular_movies, ...upcoming_movies];
      // print(_movies);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home page"),
        centerTitle: true,
      ),
      body: _movies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return ListTile(
                  title: Text(movie['title']),
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                  ),
                  subtitle: Text(movie['overview']),
                );
              },
            ),
    );
  }
}