import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/movies_provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;
  
  const CastingCards({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MovieProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId), // Llama a la API para obtener actores
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 180,
            child: CupertinoActivityIndicator(), // Muestra loading mientras carga
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 260,
          // "Rueda de oruga" para los actores
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _CastCard(actor: cast[index]),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard({required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/cargando.gif'),
              image: NetworkImage(actor.fullProfilePath), // Imagen del actor
              height: 140,
              width: 100,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/noimagen.gif', height: 140, width: 100, fit: BoxFit.cover);
              },
            ),
          ),
          const SizedBox(height: 5),
          Text(
            actor.name, // Nombre del actor
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}