import 'package:movie_app/model/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getListMovie();
}
