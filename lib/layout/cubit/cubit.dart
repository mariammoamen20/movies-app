import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/models/categories_model.dart';
import 'package:movie_app/models/popular_movies_model.dart';
import 'package:movie_app/models/top_rated_model.dart';
import 'package:movie_app/models/watch_list_movie_model.dart';
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
    const MoviesScreen(),
    const WatchListScreen(),
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
  Map<int?, bool?> favourites = {};

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
      print(favourites.toString());
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

  PopularMovieModel? search;

  void getMoviesBySearch({required String text}) {
    emit(SearchMoviesLoadingState());
    DioHelper.getData(endPoint: SEARCH, queryParameters: {
      'api_key': API_KEY,
      'query': text,
    }).then((value) {
      search = PopularMovieModel.fromJson(value.data);
      emit(SearchMoviesSuccessState());
    }).catchError((error) {
      print(error);
      emit(SearchMoviesErrorState(error));
    });
  }

  CategoriesModel? categoriesModel;

  void getMoviesCategories() {
    emit(MoviesCategoriesLoadingState());
    DioHelper.getData(
      endPoint: CATEGORIES,
      queryParameters: {
        'api_key': API_KEY,
      },
    ).then((value) {
      print('data befor json${value.data}');
      //value de 3bara 3n json w an fe satr 132 ba5od el json w atl3 mnw el data
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(MoviesCategoriesSuccessState());
    }).catchError((error) {
      print(error);
      emit(MoviesCategoriesErrorState(error));
    });
  }

/*
*  void createNewPost(
      {required String dateTime, required String text, String? postImage}) {
    PostModel model = PostModel(
        name: userModel?.name,
        uId: userModel?.uId,
        image: userModel?.image,
        dateTime: dateTime,
        text: text,
        postImage: postImage ?? " ");
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreateNewPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateNewPostErrorState(error.toString()));
    });
  }*/

  void addMoviesToWatchlist(
      {required int id,
      required String image,
      required String title,
      required String releaseDate,
      required double voteRate,
      required isClicked}) {
    emit(AddMovieToWatchlistLoadingState());
    WatchListMovieModel watchListMovieModel = WatchListMovieModel(
      id,
      image,
      title,
      releaseDate,
      voteRate,
      isClicked,
    );
    FirebaseFirestore.instance
        .collection('movies')
        .add(watchListMovieModel.toMap())
        .then((value) {
      print(value);
      emit(AddMovieToWatchlistSuccessState());
    }).catchError((error) {
      print(error);
      emit(AddMovieToWatchlistErrorState(error));
    });
  }

  bool isWatched = false;

  void changeWatchlistIcon() {
    isWatched = !isWatched;
    emit(ChangeIconWatchlistState());
  }

/*
*  List<MessageModel>? messages ;

  void getMessage({required String? receiverId}) {
    messages = [];
    FirebaseFirestore.instance
        .collection('users')
                .snapshots()
        .listen(
      (event) {
        event.docs.forEach(
          (element) {
            messages?.add(
              MessageModel.fromJson(
                element.data(),
              ),
            );
          },
        );
        emit(SocialGetAllMessageSuccessState());
      },
    );
  }
* */
  //realtime database using snapshot listen
  List<WatchListMovieModel>? movies;

  void getMovies() {
    emit(GetMoviesLoadingState());
    FirebaseFirestore.instance.collection('movies').snapshots().listen((event) {
      movies = [];
      event.docs.forEach(
        (element) {
          movies?.add(
            WatchListMovieModel.fromJson(
              element.data(),
            ),
          );
          print(element.data()['id']);
        },
      );
      emit(AddMovieToWatchlistSuccessState());
    });
  }

/*
 *
 * void getMovies() {
    movies = [];
    emit(GetMoviesLoadingState());
    FirebaseFirestore.instance.collection('movies').get().then(
      (value) {
        value.docs.forEach((element) {
          movies.add(WatchListMovieModel.fromJson(element.data()));
        });
        emit(GetMoviesSuccessState());
      },
    ).catchError(
      (error) {
        print(error);
        emit(GetMoviesErrorState(error));
      },
    );
  }*/

}
