part of 'tvshow_bloc.dart';

abstract class TvshowEvent extends Equatable {
  const TvshowEvent();

  @override
  List<Object> get props => [];
}

class GetTvshowEvent extends TvshowEvent {}
