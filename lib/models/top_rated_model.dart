class TopRatedMoviesModel {
  int? page;
  List<TopRatedResults>? results=[];
  TopRatedMoviesModel.fromJson(Map<String,dynamic> json){
    page = json['page'];
    if( json['results'] != null){
      json['results'].forEach((elements){
        results?.add(TopRatedResults.fromJson(elements));
        //print('elements $elements');
      });
    }
  }
}

class TopRatedResults {
  bool? adult;
  String? image;
  List<int>? generIds;
  int? id;
  String? title;
  String? moviePoster;
  String? releaseDate;
  dynamic voteRate;
  TopRatedResults.fromJson(dynamic json){
    adult = json['adult'];
    image = json['backdrop_path'];
    if( json['genre_ids'] != null){
      json['genre_ids'].forEach((element) {
        generIds?.add(element);
      },);
    }

    id = json['id'];
    title = json['title'];
    moviePoster = json['poster_path'];
    releaseDate = json['release_date'];
    voteRate = json['vote_average'];
  }
}