import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/models/movies_details_model.dart';
import 'package:movie_app/models/movies_details_saimilr_model.dart';
import 'package:movie_app/shared/components/constants.dart';
import 'package:movie_app/shared/network/remote/dio_helper.dart';
import 'package:movie_app/shared/network/remote/end_points.dart';

part 'state.dart';

class MoviesDetailsCubit extends Cubit<MoviesDetailsStates> {
  MoviesDetailsCubit() : super(MoviesDetailsInitial());

  static MoviesDetailsCubit get(context) => BlocProvider.of(context);

  MoviesDetailsModel? moviesDetailsModel;
  void getMovieDetails(int? id) {
    emit(MoviesDetailsLoadingState());
    DioHelper.getData(
      endPoint: MOVIE_DETAILS(id ?? 77207),
      queryParameters: {
        'api_key':API_KEY,
      },
    ).then((value) {
    moviesDetailsModel  = MoviesDetailsModel.fromJson(value.data);
   // print(value.data);
    emit(MoviesDetailsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(MoviesDetailsErrorState(error.toString()));
    });
  }

  MoviesDetailsSaimilrModel? moviesDetailsSaimilrModel;
  void getMoviesDetailsSamilir(int? id){
    emit(MoviesDetailsSamilirLoadingState());
    DioHelper.getData(endPoint: MOVIE_DETAILS_SAMILIR(id??0),queryParameters: {
      'api_key':API_KEY,
    }).then((value){
      moviesDetailsSaimilrModel = MoviesDetailsSaimilrModel.fromJson(value.data);
      emit(MoviesDetailsSamilirSuccessState());
    }).catchError((error){
      print(error);
      emit(MoviesDetailsSamilirErrorState(error));
    });
  }
}
