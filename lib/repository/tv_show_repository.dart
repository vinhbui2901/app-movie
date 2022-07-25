import 'package:movie_app/model/tv_show.dart';

abstract class TvShowRepository {
  Future<List<TvShow>> getListTvShow();
}
