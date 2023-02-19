import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/modules/movie_details/cubit/cubit.dart';
import 'package:movie_app/shared/components/components.dart';

import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class MoviesDetailsScreen extends StatelessWidget {
  String title;
  int id;

  MoviesDetailsScreen({required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesDetailsCubit()..getMovieDetails(id)..getMoviesDetailsSamilir(id),
      child: BlocConsumer<MoviesDetailsCubit, MoviesDetailsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MoviesDetailsCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildMovieVideo(context),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ConditionalBuilder(
                            condition:
                                cubit.moviesDetailsModel?.backdropPath != null,
                            builder: (context) => SizedBox(
                              height: 200.0,
                              child: buildMovieItem(
                                  image:
                                      'https://image.tmdb.org/t/p/original${cubit.moviesDetailsModel?.posterPath}'),
                            ),
                            fallback: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200.0,
                              height: 20.0,
                              child: ListView.separated(
                                separatorBuilder: (context,index){
                                  return const SizedBox(width: 3.0,);
                                },
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: defaultText(
                                        text: cubit.moviesDetailsModel
                                            ?.genres![index].name ??
                                            " ",
                                        color: Colors.white,
                                        fontSize: 8.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  );
                                },
                                itemCount: cubit.moviesDetailsModel?.genres?.length ?? 0 ,
                              ),
                            ),
                            SizedBox(
                              width: 200.0,
                              height: 150.0,
                              child: SingleChildScrollView(
                                child: Text(
                                  cubit.moviesDetailsModel?.overview ?? " ",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0,),
                            Row(
                              children: [
                                const Icon(
                                  IconBroken.Star,
                                  color: Colors.yellow,
                                  size: 15.0,
                                ),
                                defaultText(
                                  text:
                                      '${cubit.moviesDetailsModel?.voteAverage}',
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: listColor,
                    ),
                    child: SizedBox(
                        height: 200,
                        child: buildRecommendedList(context)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildMovieVideo(context) {
    var cubit = MoviesDetailsCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConditionalBuilder(
          condition: cubit.moviesDetailsModel?.backdropPath != null,
          builder: (context) => videoPlayerItem(
              image:
                  'https://image.tmdb.org/t/p/original${cubit.moviesDetailsModel?.backdropPath}'),
          fallback: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: defaultText(
            text: cubit.moviesDetailsModel?.title ?? " ",
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w100,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: defaultText(
            text: cubit.moviesDetailsModel?.releaseDate ?? " ",
            color: Colors.grey,
            fontSize: 12.0,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }

  //recommended movies section
  Widget buildRecommendedList(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          defaultText(
            text: 'More Like This',
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView.separated(
              //shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return buildRecommsendeItem(context, index);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 5.0,
                );
              },
              itemCount:10,
            ),
          )
        ],
      ),
    );
  }

//recommended movies Item
  Widget buildRecommsendeItem(context, index) {
    var cubit = MoviesDetailsCubit.get(context);
    return SingleChildScrollView(
      child: Card(
        elevation: 5.0,
        color: recommendedCardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 80.0,
                child: ConditionalBuilder(
                  condition: cubit.moviesDetailsSaimilrModel?.results![index].backdropPath != null,
                  builder: (context) => buildMovieItem(
                      image:
                      'https://image.tmdb.org/t/p/original${cubit.moviesDetailsSaimilrModel?.results![index].backdropPath}'),
                  fallback: (BuildContext context) {
                    return const Center(child: CircularProgressIndicator());
                  },
                )),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              child: Row(
                children: [
                  const Icon(
                    IconBroken.Star,
                    color: Colors.yellow,
                    size: 15.0,
                  ),
                  defaultText(
                    text:
                    '${cubit.moviesDetailsSaimilrModel?.results![index].voteAverage}',
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                  )
                ],
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              child: SizedBox(
                width: 110.0,
                child: defaultText(
                  text: cubit.moviesDetailsSaimilrModel?.results![index].title ?? " ",
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              child: defaultText(
                text:cubit.moviesDetailsSaimilrModel?.results![index].releaseDate ?? "",
                color: Colors.grey,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
