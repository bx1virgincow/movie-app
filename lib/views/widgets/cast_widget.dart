import 'package:flutter/material.dart';
import 'package:movieapp/common/cast_sample_data.dart';
import 'package:movieapp/common/color.dart';

class CastWidget extends StatelessWidget {
  final CastSampleData castSampleData;
  const CastWidget({super.key, required this.castSampleData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Card(
        elevation: 4,
        surfaceTintColor: MovieAppColor.avatarBgColor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(castSampleData.imagePath),
                  ),
                ),
              ),
              //space
              const SizedBox(height: 10),
              //cast name
              Text(castSampleData.name)
            ],
          ),
        ),
      ),
    );
  }
}
