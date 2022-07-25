// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tvshow_bloc.dart';

abstract class TvshowState extends Equatable {
  const TvshowState();

  @override
  List<Object> get props => [];
}

class LoadingTvshowState extends TvshowState {}

class LoadedTvshowState extends TvshowState {
  final List<TvShow> tvshow;
  LoadedTvshowState({
    required this.tvshow,
  });
  @override
  List<Object> get props => [tvshow];
}

class ErrorTvshowState extends TvshowState {
  final String error;

  ErrorTvshowState({required this.error});

  @override
  List<Object> get props => [error];
}
