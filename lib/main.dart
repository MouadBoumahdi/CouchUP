import 'package:couchup/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // final api = NowPlayingService();
  runApp(MyApp());

  // try {
  //   final movies = await api.getNowPlayingMovies();
  //   for (var movie in movies) {
  //     print(movie);
  //   }
  // }catch(e) {
  //   print(e);
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage(),
    debugShowCheckedModeBanner: false);
  }
}