import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/repository/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;
  MovieBloc({required this.movieRepository}) : super(LoadingState()) {
    on<LoadedDataEvent>((event, emit) async {
      emit(LoadingState());
      try {
        List<Movie> apiResult = await movieRepository.getListMovie();
        emit(LoadedState(apiResult: apiResult));
      } catch (e) {
        emit(ErrorState(error: e.toString()));
      }
    });
  }
}
