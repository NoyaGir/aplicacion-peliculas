import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

import '../models/models.dart';


class CardSwiper extends StatelessWidget {
  final List movies;
  const CardSwiper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
   final size = MediaQuery.of(context).size;
   return SizedBox(
    width: double.infinity,
    height: size.height * 0.5,
    child: Swiper(
      itemCount: movies.length,
     layout: SwiperLayout.STACK, // Vuelve al diseño apilado
     itemWidth: size.width * 0.6, // Define el ancho de la tarjeta central
     itemHeight: size.height * 0.4, // Define el alto de la tarjeta central
      itemBuilder: (_, int index){
        final movie = movies[index];
        movie.heroId = 'swiper-${movie.id}';
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/cargando.gif'), //imagen de cargar
              image: NetworkImage(movie.fullPosterImg),
              fit: BoxFit.cover,

              imageErrorBuilder: (context, error, stackTrace) {
    // Imagen que se muestra si hay un error o no encuentra la imagen
              return Image.asset(
               'assets/no-image.png',
                fit: BoxFit.cover,
                 );
                },
              ),
          )
        );
      }
    ),//asadasda
   );
    
  }
}