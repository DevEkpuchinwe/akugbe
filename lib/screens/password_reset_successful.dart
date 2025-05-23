import 'package:akugbe/screens/login.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../config/text_styles.dart';
import '../custom_widgets/filled_stateless_button.dart';

class PasswordResetSuccessful extends ConsumerStatefulWidget {
  const PasswordResetSuccessful({super.key});

  @override
  ConsumerState createState() => _PasswordResetSuccessfulState();
}

class _PasswordResetSuccessfulState
    extends ConsumerState<PasswordResetSuccessful> with AppNavigator {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: GlobalColors.blackColor,
                    )),
                30.verticalSpace,
                Center(child: Image.asset("assets/shield.png")),
                10.verticalSpace,
                Center(
                  child: Text(
                    "Reset Successful",
                    style: header,
                  ),
                ),
                20.verticalSpace,
                Center(
                  child: Text(
                    "You have successfully created a new password",
                    style: normalText,
                  ),
                ),
                20.verticalSpace,
                FilledStatelessButton(
                    buttonColor: GlobalColors.primaryColor,
                    textColor: GlobalColors.blackColor,
                    text: "Login",
                    onTap: () {
                       pushTo(context, const Login());
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
