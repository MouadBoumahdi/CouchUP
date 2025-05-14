import 'package:couchup/model/movie.dart';
import 'package:couchup/services/now_playing_service.dart';
import 'package:flutter/material.dart';
// import 'package:couchup/services/top_rated_service.dart';
// import 'package:couchup/services/popular_service.dart';
// import 'package:couchup/services/upcoming_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Movie>> nowPlaying;


  @override
  void initState() {
    super.initState();
    nowPlaying = NowPlayingService().getNowPlayingMovies();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home page"),
        centerTitle: true,
        leading: Icon(Icons.menu),
        actions:const [
          Icon(Icons.search),
          SizedBox(width: 20,),
          Icon(Icons.bookmark),
          SizedBox(width: 10,),
        ],
      ),
      body: Padding(padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text("Now Playing",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black
          ),),
          SizedBox(height: 10,),
          FutureBuilder(future: nowPlaying, builder: (context,snapshot){
            if(snapshot.hasData){
               return Center(child: CircularProgressIndicator(),);
            }
          })
        ],
      ),
      ),
      

    );
  }
}