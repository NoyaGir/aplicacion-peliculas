import 'package:flutter/material.dart';
import '../models/models.dart';
// Asume que vas a crear el widget del casting más adelante
import '../widgets/casting_cards.dart'; 

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recibimos la película por los argumentos de la ruta
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      // CustomScrollView nos permite usar Slivers para efectos de scroll avanzados
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie), // El póster que se encoge
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie: movie),
              _Overview(movie: movie),
              CastingCards(movieId: movie.id), // Widget para los actores (siguiente paso)
            ])
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200, // Altura de la imagen extendida
      floating: false,
      pinned: true, // Esto hace que el título se quede fijo arriba al hacer scroll
      // Icono 'X' (Close) a la derecha
      actions: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        )
      ],
      // Si no queremos la flecha de regreso por defecto, la ocultamos
      automaticallyImplyLeading: false, 
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black12, // Sombra sutil para que el texto sea legible
          child: Text(
            movie.title, // El título aparecerá en la barra
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        // Imagen de fondo (backdrop)
        background: FadeInImage(
          placeholder: const AssetImage('assets/cargando.gif'),
          // Usamos backdropPath si existe, si no, reutilizamos fullPosterImg
          image: NetworkImage(
            movie.backdropPath != null 
              ? 'https://image.tmdb.org/t/p/w500${movie.backdropPath}' 
              : movie.fullPosterImg
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;
  const _PosterAndTitle({required this.movie});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/cargando.gif'),
              image: NetworkImage(movie.fullPosterImg),
              height: 150,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          // ConstrainedBox para que el texto no desborde la pantalla
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 160),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textTheme.headlineSmall, overflow: TextOverflow.ellipsis, maxLines: 2),
                Text(movie.originalTitle, style: textTheme.titleMedium, overflow: TextOverflow.ellipsis, maxLines: 2),
                Row(
                  children: [
                    const Icon(Icons.star_outline, size: 15, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text('${movie.voteAverage}', style: textTheme.bodySmall) // Calificación
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;
  const _Overview({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview, // Descripción
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}