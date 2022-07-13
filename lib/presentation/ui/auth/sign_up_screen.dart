import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/presentation/theme/theme.dart';
import 'package:flutter_login_app/presentation/ui/auth/sign_in_screen.dart';
import 'package:flutter_login_app/presentation/ui/auth/success_sign_up_screen.dart';
import 'package:flutter_login_app/presentation/utils/fire_auth.dart';
import 'package:flutter_login_app/presentation/utils/next_screen.dart';
import 'package:flutter_login_app/presentation/widgets/button/button_primary.dart';
import 'package:flutter_login_app/presentation/widgets/textfiled/custom_input_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmntroller =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      User? user = await FireAuth.registerUsingEmailPassword(
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        phoneNumber: _phoneController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (user != null) {
        // ignore: use_build_context_synchronously
        nextScreenRemoveUntil(context, const SuccessSignInScreen());
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: const Text('Gagal Register'),
              backgroundColor: kPrimaryColor),
        );
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
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kGreyColor, //change your color here
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.symmetric(horizontal: marginDefault, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register',
                style: primaryTextStyle.copyWith(
                  fontSize: fontSizeOverLarge,
                  fontWeight: bold,
                ),
              ),
              Text(
                'Make an account',
                style: blackTextStyle.copyWith(
                  fontSize: fontSizeDefault,
                  fontWeight: regular,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomInputText(
                  title: 'Username',
                  hintText: 'ex: denishdoe',
                  controller: _usernameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please complete the username';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomInputText(
                  title: 'Password',
                  hintText: 'Enter your password',
                  passwordMode: true,
                  autoValid: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please complete the password';
                    } else if (value.length <= 4) {
                      return 'Min 4 character';
                    } else {
                      return null;
                    }
                  },
                  controller: _passwordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomInputText(
                  title: 'Confirm Password',
                  hintText: 'Enter your password',
                  passwordMode: true,
                  autoValid: true,
                  controller: _passwordConfirmntroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please complete the password';
                    } else if (value != _passwordController.text) {
                      return 'Must be same as password';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomInputText(
                  title: 'Number Phone',
                  hintText: 'ex: 08232418xx',
                  inputType: TextInputType.phone,
                  controller: _phoneController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please complete the number phone';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: CustomInputText(
                  title: 'Email',
                  hintText: 'ex: denishdoe@roketin.com',
                  inputType: TextInputType.emailAddress,
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
              ButtonPrimary(
                  isLoading: _isLoading,
                  title: 'Register',
                  onTap: () {
                    setState(() {
                      _isLoading = true;
                    });
                    _submitForm();
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: greyTextStyle.copyWith(
                          fontSize: fontSizeDefault, fontWeight: regular),
                    ),
                    GestureDetector(
                      onTap: () {
                        nextScreenRemoveUntil(context, const SignInSceen());
                      },
                      child: Text(
                        'Back to Login',
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
    );
  }
}
