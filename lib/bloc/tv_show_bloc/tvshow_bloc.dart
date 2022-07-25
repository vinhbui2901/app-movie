// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:movie_app/model/tv_show.dart';
import 'package:movie_app/repository/tv_show_repository.dart';

part 'tvshow_event.dart';
part 'tvshow_state.dart';

class TvshowBloc extends Bloc<TvshowEvent, TvshowState> {
  final TvShowRepository tv_show_repository;
  TvshowBloc({required this.tv_show_repository}) : super(LoadingTvshowState()) {
    on<GetTvshowEvent>((event, emit) async {
      emit(LoadingTvshowState());
      try {
        List<TvShow> responseApiTvshow =
            await tv_show_repository.getListTvShow();
        emit(LoadedTvshowState(tvshow: responseApiTvshow));
      } catch (e) {
        emit(ErrorTvshowState(error: e.toString()));
      }
    });
  }
}
