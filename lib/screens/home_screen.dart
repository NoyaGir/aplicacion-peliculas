import 'package:flutter/material.dart';
import 'package:peliculas202633/providers/movies_provider.dart';
import 'package:peliculas202633/widgets/card_swiper.dart';
// Asegúrate de importar el nuevo widget:
import 'package:peliculas202633/widgets/movie_slider.dart'; 
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        elevation: 0,
      ),
      // Envuelve tu Column en un SingleChildScrollView
      body: SingleChildScrollView( 
        child: Column(
          children: [
            // Swiper Principal (Películas en cartelera)
            if (moviesProvider.onDisplayMovies.isEmpty)
               const SizedBox(
                 height: 400,
                 child: Center(child: CircularProgressIndicator()),
               )
            else
               CardSwiper(movies: moviesProvider.onDisplayMovies),

            // Nuevo Slider Horizontal (Películas populares)
            MovieSlider(
              movies: moviesProvider.popularMovies, // Pasamos la lista de populares
              title: 'Populares', // Título opcional
            ),
          ],
        ),
      )
    );
  }
}