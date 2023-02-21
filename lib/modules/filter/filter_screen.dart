import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/popular_movies_model.dart';
import 'package:movie_app/modules/filter/cubit/cubit.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';

class FiltterScreen extends StatelessWidget {
  int id = 0;
  String text = '';

  FiltterScreen({
    required this.id,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesCubit()..getMoviesList(),
      child: BlocConsumer<MoviesCubit, MoviesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MoviesCubit.get(context);
          // ignore: unrelated_type_equality_checks
          List<Results>? moviesByGenre =
              cubit.movies?.results?.where((element) {
            // print( element.generIds?.contains(id));
            return element.generIds![0] == id;
          }).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text(text),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ConditionalBuilder(
                    condition: moviesByGenre != null,
                    builder: (context) => ListView.separated(
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 120.0,
                              height: 110.0,
                              child: ConditionalBuilder(
                                condition: cubit.movies?.results != null,
                                builder: (context) => Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/original${moviesByGenre![index].moviePoster}'),
                                ),
                                fallback: (BuildContext context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150.0,
                                    child: defaultText(
                                      maxLine: 2,
                                      text: moviesByGenre![index].title ?? " ",
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  defaultText(
                                    text: cubit.movies?.results![index]
                                            .releaseDate ??
                                        " ",
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    width: 150.0,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          IconBroken.Star,
                                          color: Colors.yellow,
                                          size: 12.0,
                                        ),
                                        const SizedBox(
                                          width: 3.0,
                                        ),
                                        defaultText(
                                          text:
                                              '${cubit.movies?.results![index].voteRate}',
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Colors.grey,
                        );
                      },
                      itemCount: moviesByGenre?.length ?? 0,
                    ),
                    fallback: (context) {
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
