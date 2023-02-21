import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/categories_model.dart';
import 'package:movie_app/models/popular_movies_model.dart';
import 'package:movie_app/modules/filter/cubit/cubit.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';

class FiltterScreen extends StatelessWidget {
  int id = 0;

  FiltterScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesCubit()..getMoviesList(),
      child: BlocConsumer<MoviesCubit, MoviesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MoviesCubit.get(context);
          List<CategoriesModel>genres =[];
          var selectedGenres = genres.map((e) => e.genres).toList();
          var filteredMovies = cubit.movies?.results?.where((element) {
            print('elemnts $element'); //geners name overview relesase date
            bool shouldAdd = false; //false
            //i = 0       i<3
            for (int i = 0; i < element.generIds!.length; i++) {
              //28,
              // 12,
              // 878
              if(selectedGenres.contains(element.generIds![i])){
                print('true or false -> ${cubit.movies?.results![i].generIds?.contains(id)}');
                shouldAdd = true;
                break;
              }
            }
            return shouldAdd;
          }).toList();
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 120.0,
                            height: 110.0,
                            child: ConditionalBuilder(
                              condition: false,
                              builder: (context) => Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/original${filteredMovies![index].moviePoster}'),
                              ),
                              fallback: (BuildContext context) {
                                return const Center(
                                    child: CircularProgressIndicator());
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
                                    text: filteredMovies![index].title??
                                        " ",
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
                      return Divider(
                        color: Colors.grey,
                      );
                    },
                    itemCount: filteredMovies?.length ??0,
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
