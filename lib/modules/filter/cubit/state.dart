part of 'cubit.dart';

@immutable
abstract class MoviesStates {}

class MoviesInitial extends MoviesStates {}

class MoviesLoadingState extends MoviesStates {}

class MoviesSuccessState extends MoviesStates {}

class MoviesErrorState extends MoviesStates {
  final String error;

  MoviesErrorState(this.error);
}
