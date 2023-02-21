import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/models/movies_details_model.dart';
import 'package:movie_app/models/movies_details_saimilr_model.dart';
import 'package:movie_app/models/popular_movies_model.dart';
import 'package:movie_app/shared/components/constants.dart';
import 'package:movie_app/shared/network/remote/dio_helper.dart';
import 'package:movie_app/shared/network/remote/end_points.dart';

part 'state.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit() : super(MoviesInitial());

  static MoviesCubit get(context) => BlocProvider.of(context);

  PopularMovieModel? movies;
  void getMoviesList() {
    emit(MoviesLoadingState());
    DioHelper.getData(
      endPoint: FILTER,
      queryParameters: {
        'api_key':API_KEY,
      },
    ).then((value) {
    movies  = PopularMovieModel.fromJson(value.data);
   // print(value.data);
    emit(MoviesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(MoviesErrorState(error.toString()));
    });
  }

}
