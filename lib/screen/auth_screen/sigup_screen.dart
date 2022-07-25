import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:movie_app/screen/animation/custom_page_router.dart';
import 'package:movie_app/screen/main_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _emailSignUpController = TextEditingController();

  final TextEditingController _passwordSignUpController =
      TextEditingController();

  final TextEditingController _confirmPasswordSignUpController =
      TextEditingController();

  String? Function(String?)? validatorEmail = (String? email) {
    if (email == null || email.isEmpty) {
      return "Can not be empty";
    }
    if (!EmailValidator.validate(email)) {
      return "Invalid email";
    }
    return null;
  };

  String? Function(String?)? validatorFullName = (String? fullName) {
    if (fullName == null || fullName.isEmpty) {
      return "Can not be empty";
    }
    if (fullName.length < 3) {
      return "Enter at least 3 characters";
    }
    return null;
  };

  String? Function(String?)? validatorPassword = (String? pass) {
    if (pass == null || pass.isEmpty) {
      return "Can not be empty";
    }
    if (pass.length < 6) {
      return "Enter at least 6 characters";
    }
    return null;
  };

  void _createAccountWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpEvent(_fullNameController.text, _emailSignUpController.text,
            _confirmPasswordSignUpController.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ),
            );
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
                                'Account already exists. Please re-register.',
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
        builder: (context, state) {
          if (state is Loading) {
            return Container(
                height: double.infinity,
                width: double.infinity,
                color: Color(0xff070a20),
                child: Center(child: CircularProgressIndicator()));
          }
          if (state is UnAuthenticated) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: Color(0xff070a20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.arrow_back_outlined),
                            color: Color(0xffffffff),
                          ),
                        ),
                        Text(
                          'Create New',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 22.sp,
                            color: Color(0xffffffff),
                          ),
                        ),
                        Text(
                          'Your Account',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 22.sp,
                            color: Color(0xffffffff),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Image.asset('assets/icons/user.png'),
                        SizedBox(height: 15.h),
                        buildTextField('Full Name', false, _fullNameController,
                            TextInputType.name, validatorFullName),
                        SizedBox(height: 15.h),
                        buildTextField(
                            'Email Address',
                            false,
                            _emailSignUpController,
                            TextInputType.emailAddress,
                            validatorEmail),
                        SizedBox(height: 15.h),
                        buildTextField(
                            'Password',
                            true,
                            _passwordSignUpController,
                            TextInputType.text,
                            validatorPassword),
                        SizedBox(height: 15.h),
                        buildTextField(
                            'Confirm Password',
                            true,
                            _confirmPasswordSignUpController,
                            TextInputType.text, (value) {
                          if (value == null || value.isEmpty) {
                            return "Can not be empty";
                          }
                          if (value != _passwordSignUpController.text) {
                            return 'Please confirm password again';
                          }
                        }),
                        SizedBox(height: 40.h),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 60.h,
                            width: 255.w,
                            child: ElevatedButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                _createAccountWithEmailAndPassword(context);
                              },
                              child: Text(
                                'Sign Up',
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
    );
  }

  Widget buildTextField(
      String text,
      bool obscureText,
      TextEditingController textController,
      TextInputType textInputType,
      String? Function(String?)? value) {
    return Container(
      child: TextFormField(
        controller: textController,
        keyboardType: textInputType,
        obscureText: obscureText,
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
          labelText: text,
          labelStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: Color(0x99ffffff),
          ),
          hintText: text,
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
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Color(0x99ffffff)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Color(0x99ffffff)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red,
            ),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: value,
      ),
    );
  }
}
