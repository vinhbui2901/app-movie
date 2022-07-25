part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {}

class LoadingState extends MovieState {
  @override
  List<Object> get props => [];
}

class LoadedState extends MovieState {
  final List<Movie> apiResult;

  LoadedState({required this.apiResult});
  @override
  List<Object> get props => [apiResult];
}

class ErrorState extends MovieState {
  final String error;

  ErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
