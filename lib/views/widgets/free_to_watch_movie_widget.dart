import 'package:flutter/material.dart';
import 'package:movieapp/views/bloc/bloc/movie_bloc.dart';

class FreeToWatchWidget extends StatelessWidget {
  final String image;
  final IconData iconData;
  final String movieTitle;
  final String movieDate;
  final MovieBloc movieBloc;
  const FreeToWatchWidget({
    super.key,
    required this.image,
    required this.iconData,
    required this.movieTitle,
    required this.movieDate,
    required this.movieBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                height: 200,
                width: MediaQuery.of(context).size.width * .45,
                errorBuilder: (context, error, stackTrace) =>
                    const Text('Failed to load picture'),
                // loadingBuilder: (context, child, loadingProgress) =>
                //     const CircularProgressIndicator(),
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: Icon(
                iconData,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
        Text(movieTitle),
        Text(movieDate),
      ],
    );
  }
}
