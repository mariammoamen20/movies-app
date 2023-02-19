/// adult : false
/// backdrop_path : "/ejniJnlOdtSgtbh8D7u2RxT6Uli.jpg"
/// belongs_to_collection : null
/// budget : 0
/// genres : [{"id":35,"name":"Comedy"},{"id":14,"name":"Fantasy"}]
/// homepage : "https://videocine.com.mx/peliculas/cuando-sea-joven/"
/// id : 772071
/// imdb_id : "tt12076762"
/// original_language : "es"
/// original_title : "Cuando Sea Joven"
/// overview : "70-year-old Malena gets a second chance at life when she magically turns into her 22-year-old self. Now, posing as \"Maria\" to hide her true identity, she becomes the lead singer of her grandson's band and tries to recover her dream of singing, which she had to give up at some point."
/// popularity : 48.151
/// poster_path : "/6gIJuFHh5Lj4dNaPG3TzIMl7L68.jpg"
/// production_companies : [{"id":1632,"logo_path":"/cisLn1YAUuptXVBa0xjq7ST9cH0.png","name":"Lionsgate","origin_country":"US"}]
/// production_countries : []
/// release_date : "2022-09-14"
/// revenue : 0
/// runtime : 115
/// spoken_languages : [{"english_name":"Spanish","iso_639_1":"es","name":"Español"}]
/// status : "Released"
/// tagline : ""
/// title : "Cuando Sea Joven"
/// video : false
/// vote_average : 8.785
/// vote_count : 202

class MoviesDetailsModel {
  bool? _adult;
  String? _backdropPath;
  dynamic? _belongsToCollection;
  int? _budget;
  List<Genres>? _genres;
  String? _homepage;
  int? _id;
  String? _imdbId;
  String? _originalLanguage;
  String? _originalTitle;
  String? _overview;
  double? _popularity;
  String? _posterPath;
  List<Production_companies>? _productionCompanies;
  List<dynamic>? _productionCountries;
  String? _releaseDate;
  int? _revenue;
  int? _runtime;
  List<Spoken_languages>? _spokenLanguages;
  String? _status;
  String? _tagline;
  String? _title;
  bool? _video;
  double? _voteAverage;
  int? _voteCount;

  bool? get adult => _adult;
  String? get backdropPath => _backdropPath;
  dynamic? get belongsToCollection => _belongsToCollection;
  int? get budget => _budget;
  List<Genres>? get genres => _genres;
  String? get homepage => _homepage;
  int? get id => _id;
  String? get imdbId => _imdbId;
  String? get originalLanguage => _originalLanguage;
  String? get originalTitle => _originalTitle;
  String? get overview => _overview;
  double? get popularity => _popularity;
  String? get posterPath => _posterPath;
  List<Production_companies>? get productionCompanies => _productionCompanies;
  List<dynamic>? get productionCountries => _productionCountries;
  String? get releaseDate => _releaseDate;
  int? get revenue => _revenue;
  int? get runtime => _runtime;
  List<Spoken_languages>? get spokenLanguages => _spokenLanguages;
  String? get status => _status;
  String? get tagline => _tagline;
  String? get title => _title;
  bool? get video => _video;
  double? get voteAverage => _voteAverage;
  int? get voteCount => _voteCount;

  MoviesDetailsModel({
      bool? adult, 
      String? backdropPath, 
      dynamic? belongsToCollection, 
      int? budget, 
      List<Genres>? genres, 
      String? homepage, 
      int? id, 
      String? imdbId, 
      String? originalLanguage, 
      String? originalTitle, 
      String? overview, 
      double? popularity, 
      String? posterPath, 
      List<Production_companies>? productionCompanies, 
      List<dynamic>? productionCountries, 
      String? releaseDate, 
      int? revenue, 
      int? runtime, 
      List<Spoken_languages>? spokenLanguages, 
      String? status, 
      String? tagline, 
      String? title, 
      bool? video, 
      double? voteAverage, 
      int? voteCount}){
    _adult = adult;
    _backdropPath = backdropPath;
    _belongsToCollection = belongsToCollection;
    _budget = budget;
    _genres = genres;
    _homepage = homepage;
    _id = id;
    _imdbId = imdbId;
    _originalLanguage = originalLanguage;
    _originalTitle = originalTitle;
    _overview = overview;
    _popularity = popularity;
    _posterPath = posterPath;
    _productionCompanies = productionCompanies;
    _productionCountries = productionCountries;
    _releaseDate = releaseDate;
    _revenue = revenue;
    _runtime = runtime;
    _spokenLanguages = spokenLanguages;
    _status = status;
    _tagline = tagline;
    _title = title;
    _video = video;
    _voteAverage = voteAverage;
    _voteCount = voteCount;
}

  MoviesDetailsModel.fromJson(dynamic json) {
    _adult = json["adult"];
    _backdropPath = json["backdrop_path"];
    _belongsToCollection = json["belongs_to_collection"];
    _budget = json["budget"];
    if (json["genres"] != null) {
      _genres = [];
      json["genres"].forEach((v) {
        _genres?.add(Genres.fromJson(v));
      });
    }
    _homepage = json["homepage"];
    _id = json["id"];
    _imdbId = json["imdb_id"];
    _originalLanguage = json["original_language"];
    _originalTitle = json["original_title"];
    _overview = json["overview"];
    _popularity = json["popularity"];
    _posterPath = json["poster_path"];
    if (json["production_companies"] != null) {
      _productionCompanies = [];
      json["production_companies"].forEach((v) {
        _productionCompanies?.add(Production_companies.fromJson(v));
      });
    }
    if (json["production_countries"] != null) {
      _productionCountries = [];
      json["production_countries"].forEach((v) {
        _productionCountries?.add(v);
      });
    }
    _releaseDate = json["release_date"];
    _revenue = json["revenue"];
    _runtime = json["runtime"];
    if (json["spoken_languages"] != null) {
      _spokenLanguages = [];
      json["spoken_languages"].forEach((v) {
        _spokenLanguages?.add(Spoken_languages.fromJson(v));
      });
    }
    _status = json["status"];
    _tagline = json["tagline"];
    _title = json["title"];
    _video = json["video"];
    _voteAverage = json["vote_average"];
    _voteCount = json["vote_count"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["adult"] = _adult;
    map["backdrop_path"] = _backdropPath;
    map["belongs_to_collection"] = _belongsToCollection;
    map["budget"] = _budget;
    if (_genres != null) {
      map["genres"] = _genres?.map((v) => v.toJson()).toList();
    }
    map["homepage"] = _homepage;
    map["id"] = _id;
    map["imdb_id"] = _imdbId;
    map["original_language"] = _originalLanguage;
    map["original_title"] = _originalTitle;
    map["overview"] = _overview;
    map["popularity"] = _popularity;
    map["poster_path"] = _posterPath;
    if (_productionCompanies != null) {
      map["production_companies"] = _productionCompanies?.map((v) => v.toJson()).toList();
    }
    if (_productionCountries != null) {
      map["production_countries"] = _productionCountries?.map((v) => v.toJson()).toList();
    }
    map["release_date"] = _releaseDate;
    map["revenue"] = _revenue;
    map["runtime"] = _runtime;
    if (_spokenLanguages != null) {
      map["spoken_languages"] = _spokenLanguages?.map((v) => v.toJson()).toList();
    }
    map["status"] = _status;
    map["tagline"] = _tagline;
    map["title"] = _title;
    map["video"] = _video;
    map["vote_average"] = _voteAverage;
    map["vote_count"] = _voteCount;
    return map;
  }

}

/// english_name : "Spanish"
/// iso_639_1 : "es"
/// name : "Español"

class Spoken_languages {
  String? _englishName;
  String? _iso6391;
  String? _name;

  String? get englishName => _englishName;
  String? get iso6391 => _iso6391;
  String? get name => _name;

  Spoken_languages({
      String? englishName, 
      String? iso6391, 
      String? name}){
    _englishName = englishName;
    _iso6391 = iso6391;
    _name = name;
}

  Spoken_languages.fromJson(dynamic json) {
    _englishName = json["english_name"];
    _iso6391 = json["iso_639_1"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["english_name"] = _englishName;
    map["iso_639_1"] = _iso6391;
    map["name"] = _name;
    return map;
  }

}

/// id : 1632
/// logo_path : "/cisLn1YAUuptXVBa0xjq7ST9cH0.png"
/// name : "Lionsgate"
/// origin_country : "US"

class Production_companies {
  int? _id;
  String? _logoPath;
  String? _name;
  String? _originCountry;

  int? get id => _id;
  String? get logoPath => _logoPath;
  String? get name => _name;
  String? get originCountry => _originCountry;

  Production_companies({
      int? id, 
      String? logoPath, 
      String? name, 
      String? originCountry}){
    _id = id;
    _logoPath = logoPath;
    _name = name;
    _originCountry = originCountry;
}

  Production_companies.fromJson(dynamic json) {
    _id = json["id"];
    _logoPath = json["logo_path"];
    _name = json["name"];
    _originCountry = json["origin_country"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["logo_path"] = _logoPath;
    map["name"] = _name;
    map["origin_country"] = _originCountry;
    return map;
  }

}

/// id : 35
/// name : "Comedy"

class Genres {
  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  Genres({
      int? id, 
      String? name}){
    _id = id;
    _name = name;
}

  Genres.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}