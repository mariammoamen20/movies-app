import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/cubit/cubit.dart';
import 'package:movie_app/models/popular_movies_model.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:movie_app/shared/styles/colors.dart';

import '../../shared/styles/icon_broken.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: listColor,
                      borderRadius: BorderRadius.circular(50.0)),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: searchController,
                    onChanged: (value) {
                      AppCubit.get(context).getMoviesBySearch(text: value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: const Icon(
                        IconBroken.Search,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: AppCubit.get(context).search?.results != null && state is! SearchMoviesLoadingState,
                    builder: (context) => ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildMovieSearchItem(
                            (AppCubit.get(context).search?.results![index])!);
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: listColor,
                          thickness: 1,
                        );
                      },
                      itemCount:
                          AppCubit.get(context).search?.results?.length ?? 0,
                    ),
                    fallback: (BuildContext context) {
                      return Center(child: const CircularProgressIndicator());
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMovieSearchItem(Results results) {
    return Row(
      children: [
        SizedBox(
          width: 120.0,
          height: 110.0,
          child: ConditionalBuilder(
            condition: results.moviePoster != null,
            builder: (context) => Image(
              fit: BoxFit.fill,
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/original${results.image}'),
            ),
            fallback: (BuildContext context) {
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150.0,
                child: defaultText(
                  maxLine: 2,
                  text: results.title ?? " ",
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              defaultText(
                text: results.releaseDate ?? " ",
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
                  children:  [
                    const Icon(
                      IconBroken.Star,
                      color: Colors.yellow,
                      size: 12.0,
                    ),
                    const SizedBox(width: 3.0,),
                    defaultText(
                      text: '${results.voteRate}',
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
  }
}
