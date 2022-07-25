import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_app/bloc/tv_show_bloc/tvshow_bloc.dart';

class TvShowScreen extends StatelessWidget {
  const TvShowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xff070a20),
        child: Padding(
          padding: EdgeInsets.only(top: 35.h, left: 10.w, right: 10.h),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.cast_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 15.w),
                    SizedBox(
                      height: 35.h,
                      width: 35.w,
                      child: Image.asset('assets/icons/user_name.png'),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hot&New',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<TvshowBloc, TvshowState>(
                  builder: (context, state) {
                    if (state is LoadingTvshowState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ErrorTvshowState) {
                      return Center(
                        child: Text('error'),
                      );
                    }
                    if (state is LoadedTvshowState) {
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 15,
                                  crossAxisCount: 1,
                                  childAspectRatio: 1.1),
                          itemCount: state.tvshow.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffffffff),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 300.h,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(
                                        '${state.tvshow[index].coverUrl}',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  Text(
                                    '${state.tvshow[index].title}',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            );
                          });
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
