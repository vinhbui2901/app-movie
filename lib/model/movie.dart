class Movie {
  int? id;
  String? title;
  String? releaseDate;
  String? boxOffice;
  int? duration;
  String? overview;
  String? coverUrl;
  String? trailerUrl;
  String? directedBy;
  int? phase;
  String? saga;
  int? chronology;
  int? postCreditScenes;
  String? imdbId;

  Movie(
      {required this.id,
      required this.title,
      required this.releaseDate,
      required this.boxOffice,
      required this.duration,
      required this.overview,
      required this.coverUrl,
      required this.trailerUrl,
      required this.directedBy,
      required this.phase,
      required this.saga,
      required this.chronology,
      required this.postCreditScenes,
      required this.imdbId});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    releaseDate = json['release_date'];
    boxOffice = json['box_office'];
    duration = json['duration'];
    overview = json['overview'];
    coverUrl = json['cover_url'];
    trailerUrl = json['trailer_url'];
    directedBy = json['directed_by'];
    phase = json['phase'];
    saga = json['saga'];
    chronology = json['chronology'];
    postCreditScenes = json['post_credit_scenes'];
    imdbId = json['imdb_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['release_date'] = this.releaseDate;
    data['box_office'] = this.boxOffice;
    data['duration'] = this.duration;
    data['overview'] = this.overview;
    data['cover_url'] = this.coverUrl;
    data['trailer_url'] = this.trailerUrl;
    data['directed_by'] = this.directedBy;
    data['phase'] = this.phase;
    data['saga'] = this.saga;
    data['chronology'] = this.chronology;
    data['post_credit_scenes'] = this.postCreditScenes;
    data['imdb_id'] = this.imdbId;
    return data;
  }
}
