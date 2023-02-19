part of 'cubit.dart';

@immutable
abstract class MoviesDetailsStates {}

class MoviesDetailsInitial extends MoviesDetailsStates {}

class MoviesDetailsLoadingState extends MoviesDetailsStates {}

class MoviesDetailsSuccessState extends MoviesDetailsStates {}

class MoviesDetailsErrorState extends MoviesDetailsStates {
  final String error;

  MoviesDetailsErrorState(this.error);
}
class MoviesDetailsSamilirLoadingState extends MoviesDetailsStates {}

class MoviesDetailsSamilirSuccessState extends MoviesDetailsStates {}

class MoviesDetailsSamilirErrorState extends MoviesDetailsStates {
  final String error;

  MoviesDetailsSamilirErrorState(this.error);
}