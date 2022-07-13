import 'package:flutter/material.dart';
import 'package:flutter_login_app/presentation/theme/theme.dart';
import 'package:flutter_login_app/presentation/ui/auth/sign_in_screen.dart';
import 'package:flutter_login_app/presentation/utils/next_screen.dart';
import 'package:flutter_login_app/presentation/widgets/button/button_primary.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessSignInScreen extends StatefulWidget {
  const SuccessSignInScreen({Key? key}) : super(key: key);

  @override
  State<SuccessSignInScreen> createState() => _SuccessSignInScreenState();
}

class _SuccessSignInScreenState extends State<SuccessSignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
              horizontal: marginDefault, vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, bottom: 20),
                child: Image.asset(
                  'assets/images/im_checklist.png',
                  width: 120.w,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Register Success',
                  style: primaryTextStyle.copyWith(
                    fontSize: 28.sp,
                    fontWeight: bold,
                  ),
                ),
              ),
              Text(
                'You have successfully registered an account at Roketin Attendance. Please check your email, you need to confirm your an account by clicking the link we have sent your',
                style: blackTextStyle.copyWith(
                  fontSize: fontSizeDefault,
                  fontWeight: regular,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ButtonPrimary(
                  title: 'Okay',
                  onTap: () {
                    nextScreenRemoveUntil(context, const SignInSceen());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
