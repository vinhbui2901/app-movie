import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/bloc/movie_bloc/movie_bloc.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  VideoPlayerController? controller;
  String? dataUrlVideo;
  Future? _initializeVideoPlayer;
  @override
  void initState() {
    controller = VideoPlayerController.network(
      "https://www.fluttercampus.com/video.mp4",
    );
    _initializeVideoPlayer = controller!.initialize();
    controller!.setLooping(true);
    controller!.play();
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xff070a20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w, top: 25.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50.h,
                    width: 50.w,
                    child: Image.asset('assets/logo/logo.png'),
                  ),
                  SizedBox(
                    height: 35.h,
                    width: 35.w,
                    child: Image.asset('assets/icons/user_name.png'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Cartoon',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Act',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Classify',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child:
                  BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
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
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: state.apiResult.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              backgroundColor: Color(0xff070a20),
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 32.h),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 250.h,
                                          width: double.infinity,
                                          child: FutureBuilder(
                                              future: _initializeVideoPlayer,
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  return VideoPlayer(
                                                      controller!);
                                                } else {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                              })),
                                      Expanded(
                                        child: Container(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(height: 15.h),
                                                Text(
                                                  '${state.apiResult[index].title}',
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 22.sp,
                                                    color: Color(0xffffffff),
                                                  ),
                                                ),
                                                SizedBox(height: 15.h),
                                                Text(
                                                  '${state.apiResult[index].directedBy}',
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18.sp,
                                                    color: Color(0xffffffff),
                                                  ),
                                                ),
                                                SizedBox(height: 15.h),
                                                SizedBox(
                                                  height: 40.h,
                                                  width: 300.w,
                                                  child: ElevatedButton(
                                                      onPressed: () {},
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.play_arrow,
                                                            color: Colors.black,
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          Text(
                                                            'Play',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(Colors
                                                                      .white))),
                                                ),
                                                SizedBox(height: 15.h),
                                                SizedBox(
                                                  height: 40.h,
                                                  width: 300.w,
                                                  child: ElevatedButton(
                                                      onPressed: () {},
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.download,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          Text(
                                                            'DownLoad',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      Colors
                                                                          .grey))),
                                                ),
                                                SizedBox(height: 15.h),
                                                Text(
                                                  '${state.apiResult[index].overview}',
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.sp,
                                                    color: Color(0xffffffff),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Stack(
                          children: [
                            state.apiResult[index].coverUrl != null
                                ? Image.network(
                                    '${state.apiResult[index].coverUrl}')
                                : Image.asset('assets/logo/logo.png'),
                            Padding(
                              padding: EdgeInsets.only(bottom: 5.h),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  '${state.apiResult[index].title}',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return SizedBox.shrink();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
