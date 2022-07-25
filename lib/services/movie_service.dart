import 'dart:convert';
import 'package:movie_app/model/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/repository/movie_repository.dart';

class MovieService implements MovieRepository {
  String dataUrl = 'https://mcuapi.herokuapp.com/api/v1';
  @override
  Future<List<Movie>> getListMovie() async {
    List<Movie> movieList = [];
    var url = Uri.parse('$dataUrl/movies');
    var response = await http.get(url);
    print(response.statusCode);
    var body = json.decode(response.body);
    final List data = body['data'];
    for (var i = 0; i < data.length; i++) {
      movieList.add(Movie.fromJson(data[i]));
    }
    return movieList;
  }
}
