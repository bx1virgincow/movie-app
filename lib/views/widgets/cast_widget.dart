import 'package:flutter/material.dart';
import 'package:movieapp/common/color.dart';
import 'package:movieapp/domain/models/cast_model.dart';

class CastWidget extends StatelessWidget {
  final MovieCastResponse castMember;

  const CastWidget({super.key, required this.castMember});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: castMember.cast.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Card(
              elevation: 4,
              surfaceTintColor: MovieAppColor.avatarBgColor,
              child: SizedBox(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://image.tmdb.org/t/p/w200${castMember.cast[index].profilePath}',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      castMember.cast[index].name,
                      style: const TextStyle(
                        color: MovieAppColor.popularTxtColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      castMember.cast[index].character,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
