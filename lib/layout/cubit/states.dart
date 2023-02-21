part of 'cubit.dart';

@immutable
abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangeBottomNavBarState extends AppStates {}

class PopularMovieLoadingState extends AppStates {}

class PopularMovieSuccessState extends AppStates {}

class PopularMovieErrorState extends AppStates {
  final String error;

  PopularMovieErrorState(this.error);
}
class TopRatedLoadingState extends AppStates {}

class TopRatedSuccessState extends AppStates {}

class TopRatedErrorState extends AppStates {
  final String error;

  TopRatedErrorState(this.error);
}
class SearchMoviesLoadingState extends AppStates {}

class SearchMoviesSuccessState extends AppStates {}

class SearchMoviesErrorState extends AppStates {
  final String error;

  SearchMoviesErrorState(this.error);
}
class MoviesCategoriesLoadingState extends AppStates {}

class MoviesCategoriesSuccessState extends AppStates {}

class MoviesCategoriesErrorState extends AppStates {
  final String error;

  MoviesCategoriesErrorState(this.error);
}