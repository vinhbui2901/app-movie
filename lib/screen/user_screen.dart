import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:movie_app/screen/auth_screen/signin_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  void logout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('You definitely want to logout ?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                    Navigator.pop(context);
                  },
                  child: Text('Ok')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SignInScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color(0xff070a20),
          child: Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 90.h),
            child: Column(
              children: [
                Image.asset('assets/icons/user_name.png'),
                Text(
                  'Name',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Color(0xffffffff),
                  ),
                ),
                Text(
                  'Email',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: Color(0xB3ffffff),
                  ),
                ),
                buildListRow(Icons.person, "Edit Profile", () {}),
                buildListRow(Icons.language_outlined, "Change Language", () {}),
                buildListRow(Icons.topic_outlined, "Help Centre", () {}),
                buildListRow(
                    Icons.thumb_up_alt_outlined, "Rate Flutix App", () {}),
                buildListRow(Icons.logout_outlined, "Logout", logout),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildListRow(IconData icons, String text, Function() onPressed) {
    return Padding(
      padding: EdgeInsets.only(top: 14.h),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 30.h,
                width: 30.w,
                decoration: BoxDecoration(
                  color: Color(0xff3E60F9),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  icons,
                  color: Color(0xffA3BBFF),
                ),
              ),
              SizedBox(width: 16.w),
              TextButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: Color(0xB3ffffff),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          DottedLine(
            dashColor: Color(0xB3ffffff),
            lineThickness: 2,
          ),
        ],
      ),
    );
  }
}
