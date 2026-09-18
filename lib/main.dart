
import 'package:flutter/cupertino.dart';
import 'package:peliculas202633/screens/details_screen.dart';
import 'package:peliculas202633/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'providers/movies_provider.dart';
import 'package:flutter/material.dart'; // Cambia cupertino por material

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider(), lazy: false),
      ],
      child: const Myapp(),
    );
  }
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Cambia CupertinoApp por MaterialApp
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'details': (_) => const DetailsScreen(),
      },
    );
  }
}