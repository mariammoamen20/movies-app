class WatchListMovieModel {
  int? id;
  String? moviePoster;
  String? title;
  String? releaseDate;
  dynamic voteRate;

  WatchListMovieModel(
    this.id,
    this.moviePoster,
    this.title,
    this.releaseDate,
    this.voteRate,
  );

/*
* id: cubit.popularMoviesModel?.results![0].id ?? 0,
                  image: image,
                  title: cubit.popularMoviesModel?.results![index].title ?? " ",
                  releaseDate: cubit.popularMoviesModel?.results![index].releaseDate ?? " ",
                  voteRate: cubit.popularMoviesModel?.results![index].voteRate);*/
  WatchListMovieModel.fromJson(dynamic json) {
    id = json['id'];
    moviePoster = json['moviePoster'];
    title = json['title'];
    releaseDate = json['releaseDate'];
    voteRate = json['voteRate'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'moviePoster': moviePoster,
      'title': title,
      'releaseDate': releaseDate,
      'vote_average': voteRate,
    };
  }
}
