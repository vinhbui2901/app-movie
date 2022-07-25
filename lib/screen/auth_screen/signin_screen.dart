import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:movie_app/repository/auth_repository.dart';
import 'package:movie_app/screen/animation/custom_page_router.dart';
import 'package:movie_app/screen/main_screen.dart';
import 'package:movie_app/screen/auth_screen/sigup_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthRepository authRepository = AuthRepository();
  TextEditingController _emailAddressLoginController = TextEditingController();
  TextEditingController _passwordLoginController = TextEditingController();
  bool passwordLoginVisibility = false;

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      try {
        BlocProvider.of<AuthBloc>(context).add(
          SigninEvent(
              _emailAddressLoginController.text, _passwordLoginController.text),
        );
      } catch (error) {
        authRepository.error(error.toString(), context);
      }
    }
  }

  void dispose() {
    _emailAddressLoginController.dispose();
    _passwordLoginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MainScreen()));
          }
          if (state is AuthError) {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    content: Builder(builder: (context) {
                      return Container(
                        height: 153.h,
                        width: MediaQuery.of(context).size.width - 54.w,
                        child: Column(
                          children: [
                            Center(
                              child: Icon(
                                Icons.dangerous_outlined,
                                color: Colors.red,
                                size: 45.sp,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Center(
                              child: Text(
                                'Incorrect account or password. Please check again',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Ok')),
                            ),
                          ],
                        ),
                      );
                    }),
                  );
                });
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              return Container(
                height: double.infinity,
                width: double.infinity,
                color: Color(0xff070a20),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is UnAuthenticated) {
              return Container(
                height: double.infinity,
                width: double.infinity,
                color: Color(0xff070a20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 90.h, left: 24.w, right: 24.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/logo/logo_144.png'),
                          Text(
                            'Welcome Back,',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 22.sp,
                              color: Color(0xffffffff),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            'Movie Lover!',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 22.sp,
                              color: Color(0xffffffff),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Container(
                            child: TextFormField(
                              controller: _emailAddressLoginController,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              enableSuggestions: true,
                              autocorrect: true,
                              cursorColor: Color(0x99ffffff),
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: Color(0x99ffffff),
                              ),
                              decoration: new InputDecoration(
                                errorStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: Color(0x99ffffff),
                                ),
                                labelText: 'Email Address',
                                labelStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Color(0x99ffffff),
                                ),
                                hintText: 'Email Address',
                                hintStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Color(0x99ffffff),
                                ),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0x99ffffff),
                                    style: BorderStyle.none,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0x99ffffff)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0x99ffffff)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.red,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                return value != null &&
                                        !EmailValidator.validate(value)
                                    ? 'Enter a valid email'
                                    : null;
                              },
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Container(
                            child: TextFormField(
                              controller: _passwordLoginController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !passwordLoginVisibility,
                              enableSuggestions: true,
                              autocorrect: true,
                              cursorColor: Color(0x99ffffff),
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: Color(0x99ffffff),
                              ),
                              decoration: new InputDecoration(
                                errorStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: Color(0x99ffffff),
                                ),
                                labelText: 'Password',
                                labelStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Color(0x99ffffff),
                                ),
                                hintText: 'Password',
                                hintStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Color(0x99ffffff),
                                ),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0x99ffffff),
                                    style: BorderStyle.none,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0x99ffffff)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0x99ffffff)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.red,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => passwordLoginVisibility =
                                        !passwordLoginVisibility,
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    passwordLoginVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Color(0x98FFFFFF),
                                    size: 20,
                                  ),
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                return value != null && value.length < 6
                                    ? "Enter min 6 characters"
                                    : null;
                              },
                            ),
                          ),
                          SizedBox(width: 12.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 28.h),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 60.h,
                              width: 255.w,
                              child: ElevatedButton(
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _authenticateWithEmailAndPassword(context);
                                },
                                child: Text(
                                  'Sign In',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xff449eff)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 21.h),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Create new account?',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                    color: Color(0xB3ffffff),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(CustomPageRouter(
                                        child: SignUpScreen(),
                                        direction: AxisDirection.right));
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      color: Color(0xff449EFF),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 28.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 60.h,
                                width: 60.w,
                                decoration: BoxDecoration(
                                  color: Color(0xff151D3B),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Image.asset('assets/icons/google.png'),
                              ),
                              SizedBox(width: 32.w),
                              Container(
                                height: 60.h,
                                width: 60.w,
                                decoration: BoxDecoration(
                                  color: Color(0xff151D3B),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Image.asset('assets/icons/facebook.png'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
