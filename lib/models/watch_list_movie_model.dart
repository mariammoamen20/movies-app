class WatchListMovieModel {
  int? id;
  String? moviePoster;
  String? title;
  String? releaseDate;
  double? voteRate;
  bool? isClicked;

  WatchListMovieModel(
    this.id,
    this.moviePoster,
    this.title,
    this.releaseDate,
    this.voteRate,
   this.isClicked,
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
    isClicked = json['isClicked'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'moviePoster': moviePoster,
      'title': title,
      'releaseDate': releaseDate,
      'voteRate': voteRate,
      'isClicked':isClicked,
    };
  }
}
