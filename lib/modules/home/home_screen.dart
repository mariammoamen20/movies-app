import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/cubit/cubit.dart';
import 'package:movie_app/modules/movie_details/movies_details.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:movie_app/shared/styles/colors.dart';

import '../../shared/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    navigateTo(
                      context,
                      MoviesDetailsScreen(
                        title:
                            cubit.popularMoviesModel?.results![0].title ?? " ",
                        id: cubit.popularMoviesModel?.results![0].id ?? 0,
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 300,
                    child: buildPopular(context),
                  ),
                ),
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: listColor,
                  ),
                  child: moviesNewRelease(context),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: listColor,
                  ),
                  child: buildRecommendedList(context),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPopular(context) {
    var cubit = AppCubit.get(context);
    return Stack(
      children: [
        ConditionalBuilder(
            condition: cubit.popularMoviesModel?.results != null,
            builder: (context) => videoPlayerItem(
                image:
                    'https://image.tmdb.org/t/p/original${cubit.popularMoviesModel?.results![0].image}'),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator())),
        Container(
          margin: const EdgeInsetsDirectional.only(
            top: 110.0,
            start: 10.0,
          ),
          child: buildRow(context),
        ),
      ],
    );
  }

  Widget buildRow(context) {
    var cubit = AppCubit.get(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
            height: 150.0,
            width: 100.0,
            child: ConditionalBuilder(
              condition: cubit.popularMoviesModel?.results != null,
              builder: (context) => buildMovieItem(0, context,
                  image:
                      'https://image.tmdb.org/t/p/original${cubit.popularMoviesModel?.results![0].moviePoster}'),
              fallback: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
        const SizedBox(
          width: 15.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 190,
              child: defaultText(
                text: cubit.popularMoviesModel?.results![0].title ?? " ",
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            defaultText(
              text: cubit.popularMoviesModel?.results![0].releaseDate ?? " ",
              color: Colors.grey,
              fontSize: 12.0,
              fontWeight: FontWeight.w100,
            ),
          ],
        ),
      ],
    );
  }

  Widget moviesNewRelease(context) {
    var cubit = AppCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          defaultText(
            text: 'New Releases',
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ConditionalBuilder(
                  condition: cubit.popularMoviesModel?.results != null,
                  builder: (context) => GestureDetector(
                    onTap: () {
                      navigateTo(
                        context,
                        MoviesDetailsScreen(
                          title:
                              cubit.popularMoviesModel?.results![index].title ??
                                  " ",
                          id: cubit.popularMoviesModel?.results![index].id ?? 0,
                        ),
                      );
                    },
                    child: buildMovieItem(index, context,
                        image:
                            'https://image.tmdb.org/t/p/original${cubit.popularMoviesModel?.results![index].moviePoster}'),
                  ),
                  fallback: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
              itemCount: cubit.popularMoviesModel?.results?.length ?? 0,
              separatorBuilder: (context, index) => const SizedBox(
                width: 10.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //recommended movies section
  Widget buildRecommendedList(context) {
    var cubit = AppCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          defaultText(
            text: 'Recommended',
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
                return GestureDetector(
                    onTap: () {
                      navigateTo(
                        context,
                        MoviesDetailsScreen(
                          title: cubit
                                  .topRatedMoviesModel?.results![index].title ??
                              " ",
                          id: cubit.topRatedMoviesModel?.results![index].id ??
                              0,
                        ),
                      );
                    },
                    child: buildRecommsendeItem(context, index));
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 5.0,
                );
              },
              itemCount: cubit.topRatedMoviesModel?.results?.length ?? 0,
            ),
          )
        ],
      ),
    );
  }

//recommended movies Item
  Widget buildRecommsendeItem(context, index) {
    var cubit = AppCubit.get(context);
    return SingleChildScrollView(
      child: Card(
        elevation: 5.0,
        color: recommendedCardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 200.0,
                child: ConditionalBuilder(
                  condition: cubit.topRatedMoviesModel?.results != null,
                  builder: (context) => buildMovieItem(index, context,
                      image:
                          'https://image.tmdb.org/t/p/original${cubit.topRatedMoviesModel?.results![index].moviePoster}'),
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
                        '${cubit.topRatedMoviesModel?.results![index].voteRate}',
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
                  text: cubit.topRatedMoviesModel?.results![index].title ?? " ",
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
                text: cubit.topRatedMoviesModel?.results![index].releaseDate ??
                    " ",
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

  Widget buildMovieItem(index, context, {required String image}) {
    var cubit = AppCubit.get(context);
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image(
            image: NetworkImage(
              image,
            ),
            fit: BoxFit.cover,
          ),
        ),
        InkWell(
          onTap: () {
            AppCubit.get(context).addMovieToWatchlist(
                id: cubit.popularMoviesModel?.results![0].id ?? 0,
                image: image,
                title: cubit.popularMoviesModel?.results![index].title ?? " ",
                releaseDate:
                    cubit.popularMoviesModel?.results![index].releaseDate ??
                        " ",
                voteRate: cubit.popularMoviesModel?.results![index].voteRate);
            print('clickable');
          },
          child: Image.asset(
            'assets/images/add.png',
            fit: BoxFit.contain,
            width: 30.0,
            color:  Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
