import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movieapp/common/cast_sample_data.dart';
import 'package:movieapp/common/color.dart';
import 'package:movieapp/common/date_formatter.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/views/bloc/bloc/movie_bloc.dart';
import 'package:movieapp/views/widgets/cast_widget.dart';

class DetailsPage extends StatefulWidget {
  final Movie movie;
  final MovieBloc movieBloc;
  const DetailsPage({
    super.key,
    required this.movie,
    required this.movieBloc,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  //calling cast query on initState
  @override
  void initState() {
    super.initState();
    widget.movieBloc.add(OnLoadMovieCastEvent(movieId: widget.movie.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MovieAppColor.homepageColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  child: Stack(
                    children: [
                      Image(
                        height: MediaQuery.of(context).size.height / 2,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/original/${widget.movie.backdropPath}'),
                      ),
                      //back button
                      Positioned(
                        left: 20,
                        top: 20,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: MovieAppColor.avatarBgColor,
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/eva_arrow-ios-back-outline.png'))),
                        ),
                      ),

                      //favorite button
                      const Positioned(
                        top: 30,
                        right: 20,
                        child: Icon(
                          Icons.favorite_outline,
                          color: MovieAppColor.avatarBgColor,
                          size: 30,
                        ),
                      ),

                      //date
                      Positioned(
                          bottom: 70,
                          left: 20,
                          child: SizedBox(
                            width: 200,
                            child: Text(
                              widget.movie.title,
                              maxLines: 2,
                              softWrap: true,
                              style: const TextStyle(
                                color: MovieAppColor.avatarBgColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          )),

                      //title
                      Positioned(
                        bottom: 80,
                        right: 20,
                        child: Text(
                          widget.movie.voteCount.toString(),
                          style: const TextStyle(
                              color: MovieAppColor.avatarBgColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      //movie time
                      Positioned(
                        bottom: 50,
                        left: 20,
                        child: Text(
                          formatDate(widget.movie.releaseDate),
                          style: const TextStyle(
                              color: MovieAppColor.avatarBgColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      // button
                      Positioned(
                        bottom: 10,
                        left: 20,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: MovieAppColor.actionBtnColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text(
                              'Action',
                              style: TextStyle(
                                color: MovieAppColor.avatarBgColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //out of stack
                //continuing with other desings
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //movie description
                      Text(
                        widget.movie.overview,
                        style: const TextStyle(
                          color: MovieAppColor.movieOverviewColor,
                        ),
                      ),
                      //movie cast title
                      const Text(
                        'Cast',
                        style: TextStyle(fontSize: 25),
                      ),

                      //row of cast
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: castSampleData
                                .map((e) => CastWidget(castSampleData: e))
                                .toList()),
                      ),

                      //button
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: MovieAppColor.actionBtnColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Play Trailer',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              color: MovieAppColor.avatarBgColor,
                            ),
                          ),
                        ),
                      ),

                     const Center(
                        child: Text(
                          'Download',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.grey,
                                offset: Offset(5.0, 5.0),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
