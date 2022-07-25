import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/tv_show.dart';
import 'package:movie_app/repository/tv_show_repository.dart';

class TvShowService implements TvShowRepository {
  String dataUrl = 'https://mcuapi.herokuapp.com/api/v1';
  @override
  Future<List<TvShow>> getListTvShow() async {
    List<TvShow> tvShowList = [];
    var url = Uri.parse('$dataUrl/tvshows');
    var response = await http.get(url);
    print(response.statusCode);
    var body = json.decode(response.body);
    final List data = body['data'];
    for (var i = 0; i < data.length; i++) {
      tvShowList.add(TvShow.fromJson(data[i]));
    }
    return tvShowList;
  }
}
