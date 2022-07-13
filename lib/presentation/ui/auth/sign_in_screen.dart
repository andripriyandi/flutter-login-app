import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/presentation/theme/theme.dart';
import 'package:flutter_login_app/presentation/ui/auth/sign_up_screen.dart';
import 'package:flutter_login_app/presentation/utils/fire_auth.dart';
import 'package:flutter_login_app/presentation/utils/next_screen.dart';
import 'package:flutter_login_app/presentation/widgets/button/button_primary.dart';
import 'package:flutter_login_app/presentation/widgets/dialog/custom_dialog.dart';
import 'package:flutter_login_app/presentation/widgets/textfiled/custom_input_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInSceen extends StatefulWidget {
  const SignInSceen({Key? key}) : super(key: key);

  @override
  State<SignInSceen> createState() => _SignInSceenState();
}

class _SignInSceenState extends State<SignInSceen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  void _submitLogin() async {
    if (_formKey.currentState!.validate()) {
      User? user = await FireAuth.signInUsingEmailPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (user != null) {
        showDialog(
            context: context,
            builder: (context) => const CustomDialog(
                title: 'Berhasil', message: 'Berhasil Login'));
      } else {
        showDialog(
            context: context,
            builder: (context) =>
                const CustomDialog(title: 'Gagal', message: 'Gagal Login'));
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: marginDefault, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Image.asset(
                    'assets/images/im_logo.png',
                    width: 200.w,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CustomInputText(
                    title: 'Email',
                    hintText: 'ex: denishdoe@roketin',
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please complete the email';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CustomInputText(
                    title: 'Password',
                    hintText: 'Enter your password',
                    controller: _passwordController,
                    passwordMode: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please complete the password';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'Forgot Password',
                    style: greyTextStyle.copyWith(
                      fontSize: fontSizeDefault,
                      fontWeight: regular,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ButtonPrimary(
                  isLoading: _isLoading,
                  title: 'Login',
                  onTap: () {
                    setState(() {
                      _isLoading = true;
                    });
                    _submitLogin();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Want to use Roketin Attendance? ',
                        style: greyTextStyle.copyWith(
                            fontSize: fontSizeDefault, fontWeight: regular),
                      ),
                      GestureDetector(
                        onTap: () {
                          nextScreen(context, const SignUpScreen());
                        },
                        child: Text(
                          'Get it Now',
                          style: primaryTextStyle.copyWith(
                            fontSize: fontSizeDefault,
                            fontWeight: regular,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
