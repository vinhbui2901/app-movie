import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_app/model/movie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isSearch = true;
  List<Movie> _searchResult = [];
  List<Movie> _movieDetails = [];
  TextEditingController _searchController = TextEditingController();
  void onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _movieDetails.forEach((movieDetail) {
      if (movieDetail.title!.toLowerCase().contains(text.toLowerCase())) {
        _searchResult.add(movieDetail);
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xff070a20),
        child: Padding(
          padding: EdgeInsets.only(top: 35.h, right: 5.w, left: 5.h),
          child: Column(
            children: [
              _isSearch
                  ? SizedBox(
                      height: 40.h,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xff2f2f2f))),
                        onPressed: () {
                          setState(() {
                            _isSearch = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Search',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(
                      height: 40.h,
                      color: Color(0xff2f2f2f),
                      child: TextField(
                        controller: _searchController,
                        onChanged: onSearchTextChanged,
                        autofocus: true,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: Colors.grey,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),
                    ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Top search',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<MovieBloc, MovieState>(
                          builder: (context, state) {
                        if (state is LoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is ErrorState) {
                          return Center(
                            child: Text('error'),
                          );
                        }
                        if (state is LoadedState) {
                          _movieDetails = state.apiResult;

                          return (_searchResult.length != 0)
                              ? ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: _searchResult.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        height: 100.h,
                                        child: Row(
                                          children: [
                                            _searchResult[index].coverUrl !=
                                                    null
                                                ? Expanded(
                                                    flex: 2,
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: Image.network(
                                                        '${_searchResult[index].coverUrl}',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  )
                                                : Expanded(
                                                    flex: 2,
                                                    child: Image.asset(
                                                        'assets/logo/logo.png'),
                                                  ),
                                            Expanded(
                                              flex: 3,
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10.w),
                                                      child: Text(
                                                        '${_searchResult[index].title}',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14.sp,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 20.w),
                                                child: Icon(
                                                  Icons
                                                      .play_circle_outline_rounded,
                                                  size: 40.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ));
                                  })
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: _movieDetails.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        height: 100.h,
                                        child: Row(
                                          children: [
                                            _movieDetails[index].coverUrl !=
                                                    null
                                                ? Expanded(
                                                    flex: 2,
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: Image.network(
                                                        '${_movieDetails[index].coverUrl}',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  )
                                                : Expanded(
                                                    flex: 2,
                                                    child: Image.asset(
                                                        'assets/logo/logo.png'),
                                                  ),
                                            Expanded(
                                              flex: 3,
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10.w),
                                                      child: Text(
                                                        '${_movieDetails[index].title}',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14.sp,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 20.w),
                                                child: Icon(
                                                  Icons
                                                      .play_circle_outline_rounded,
                                                  size: 40.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ));
                                  });
                        }
                        return Container();
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
