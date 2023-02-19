import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/models/popular_movies_model.dart';
import 'package:movie_app/models/top_rated_movies_model.dart';
import 'package:movie_app/modules/home/home_screen.dart';
import 'package:movie_app/modules/movies/movies.dart';
import 'package:movie_app/modules/watch_list/watch_list_screen.dart';
import 'package:movie_app/shared/components/constants.dart';
import 'package:movie_app/shared/network/remote/dio_helper.dart';
import 'package:movie_app/shared/network/remote/end_points.dart';

import '../../modules/search/search_screen.dart';
import '../../shared/styles/icon_broken.dart';

part 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  List<Widget> screen = [
    HomeScreen(),
    SearchScreen(),
    MoviesScreen(),
    WatchListScreen(),
  ];

  List<BottomNavigationBarItem> bottoms = const [
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Search),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.movie),
      label: 'Browser',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Bookmark),
      label: 'WatchList',
    ),
  ];

  int currentIndex = 0;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  PopularMovieModel? popularMoviesModel;

  void getPopularMovie() {
    emit(PopularMovieLoadingState());
    DioHelper.getData(
      endPoint: POPULAR,
      queryParameters: {
        'page': 1,
        'api_key': API_KEY,
      },
    ).then((value) {
     // print('popular data ${value.data}');
      popularMoviesModel = PopularMovieModel.fromJson(value.data);
      emit(PopularMovieSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PopularMovieErrorState(error.toString()));
    });
  }

 TopRatedMoviesModel? topRatedMoviesModel;
  void getTopRated() {
    emit(TopRatedLoadingState());
    DioHelper.getData(
      endPoint: TOPRATED,
      queryParameters: {
        'api_key': API_KEY,
      },
    ).then(
          (value) {
        topRatedMoviesModel = TopRatedMoviesModel.fromJson(value.data);
        //print('top rated ${value.data}');
        emit(TopRatedSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(TopRatedErrorState(error.toString()));
    });
  }

}
