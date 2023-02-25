import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/cubit/cubit.dart';
import 'package:movie_app/models/watch_list_movie_model.dart';
import 'package:movie_app/shared/components/components.dart';

import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
       /* if(state is AddMovieToWatchlistSuccessState){
          AppCubit.get(context).getMovies();
        }*/
      },
      builder: (context, state) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              defaultText(
                text: 'Watch List',
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              ConditionalBuilder(
                condition: AppCubit.get(context).movies.isNotEmpty,
                builder:(context)=> Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildWatchlistItem(AppCubit.get(context).movies[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: listColor,
                        thickness: 1,
                      );
                    },
                    itemCount: AppCubit.get(context).movies.length,
                  ),
                ),
                fallback: (context)=>const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildWatchlistItem(WatchListMovieModel models) {
    return Row(
      children: [
        SizedBox(
          width: 120.0,
          height: 110.0,
          child: ConditionalBuilder(
            condition: true,
            builder: (context) =>
             Image(
              fit: BoxFit.fill,
              image: NetworkImage(models.moviePoster ?? " "),
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
                  text: models.title ??" ",
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              defaultText(
                text: models.releaseDate??" ",
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
                      text: '${models.voteRate}',
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
