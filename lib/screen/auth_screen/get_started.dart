import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/screen/animation/custom_page_router.dart';
import 'package:movie_app/screen/auth_screen/signin_screen.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xff070a20),
        child: Column(
          children: [
            SizedBox(
              height: 211.h,
            ),
            Image.asset('assets/logo/logo_144.png'),
            SizedBox(
              height: 54.h,
            ),
            Text(
              'New Experience',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 24.sp,
                color: Color(0xffffffff),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Column(
              children: <Widget>[
                Text(
                  'Watch a new movie much',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300,
                    fontSize: 18.sp,
                    color: Color(0xB3ffffff),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'easier than any befor',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w300,
                      fontSize: 18.sp,
                      color: Color(0xB3ffffff),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 72.h,
            ),
            SizedBox(
              height: 60.h,
              width: 255.w,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(CustomPageRouter(
                    child: SignInScreen(),
                    direction: AxisDirection.down,
                  ));
                },
                child: Text(
                  'Get Started',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Color(0xffffffff),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff449eff)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
