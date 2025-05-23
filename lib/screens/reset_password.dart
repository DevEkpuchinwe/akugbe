import 'package:akugbe/screens/verification_sent.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:akugbe/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../config/text_styles.dart';
import '../custom_widgets/filled_stateless_button.dart';
import '../custom_widgets/text_fields.dart';
import '../providers/authProvider.dart';


class ResetPassword extends ConsumerStatefulWidget {
  const ResetPassword({super.key});

  @override
  ConsumerState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends ConsumerState<ResetPassword> with AppNavigator {
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
                  IconButton(onPressed: (){
                    pop(context);
                  }, icon: Icon(Icons.arrow_back_ios_new_rounded, color: GlobalColors.blackColor,)),
                  30.verticalSpace,
                  Text("Reset Password", style: header,),
                  10.verticalSpace,
                  Text("A verification link would be sent to the email linked with this account", style: normalText,),
                  30.verticalSpace,
                  AppTextForm(
                    validator: Validators.validateEmail,
                    title: "Email address",
                    hintText: "Email",
                    controller: auth.emailController,
                  ),
                  40.verticalSpace,
                  FilledStatelessButton(
                      buttonColor: GlobalColors.primaryColor,
                      textColor: GlobalColors.blackColor,
                      text: "Submit",
                      onTap: () {
                        auth.sendOtp(context);
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

