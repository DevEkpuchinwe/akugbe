import 'package:akugbe/providers/authProvider.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../config/text_styles.dart';
import '../custom_widgets/filled_stateless_button.dart';
import '../custom_widgets/text_fields.dart';
import '../utils/validators.dart';

class CreatePassword extends ConsumerStatefulWidget {
  const CreatePassword({super.key});

  @override
  ConsumerState createState() => _CreatePasswordState();
}

class _CreatePasswordState extends ConsumerState<CreatePassword>
    with AppNavigator {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: SingleChildScrollView(
            child: Form(
              key: auth.resetPasswordKey,
              child: Column(
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
                  30.verticalSpace,
                  Text(
                    "Create new password",
                    style: header,
                  ),
                  10.verticalSpace,
                  Text(
                    "Your new password must be different from previously used password",
                    style: normalText,
                  ),
                  30.verticalSpace,
                  PasswordTextForm(
                      validator: Validators.validateRequired,
                      controller: auth.otpController,
                      text: "Enter OTP",
                      textInputType: TextInputType.text,
                      title: "OTP"),
                  30.verticalSpace,
                  PasswordTextForm(
                      validator: Validators.validatePassword,
                      controller: auth.passwordController,
                      text: "Password",
                      textInputType: TextInputType.text,
                      title: "New Password"),
                  30.verticalSpace,
                  PasswordTextForm(
                      validator: (value) {
                        return Validators.validateCPassword(
                            auth.passwordController.text,
                            auth.confirmPasswordController.text);
                      },
                      controller: auth.confirmPasswordController,
                      text: "Password",
                      textInputType: TextInputType.text,
                      title: "Confirm Password"),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: GlobalColors.unactiveColor,
                      ),
                      10.horizontalSpace,
                      Text(
                        "Both passwords must match",
                        style: normalText,
                      )
                    ],
                  ),
                  40.verticalSpace,
                  FilledStatelessButton(
                      buttonColor: GlobalColors.primaryColor,
                      textColor: GlobalColors.blackColor,
                      text: "Reset Password",
                      onTap: () {
                        auth.resetPassword(context);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
