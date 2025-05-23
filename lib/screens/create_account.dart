import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/custom_widgets/text_fields.dart';
import 'package:akugbe/screens/login.dart';
import 'package:akugbe/screens/personal_info.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/colors.dart';
import '../custom_widgets/filled_stateless_button.dart';
import '../providers/authProvider.dart';
import '../utils/validators.dart';

class CreateAccount extends ConsumerStatefulWidget {
  const CreateAccount({super.key});

  @override
  ConsumerState createState() => _CreateAccountState();
}

class _CreateAccountState extends ConsumerState<CreateAccount> with AppNavigator {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: SingleChildScrollView(
            child: Form(
              key: auth.createAccountKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){
                    pop(context);
                  }, icon: Icon(Icons.arrow_back_ios_new_rounded, color: GlobalColors.blackColor,)),
                  30.verticalSpace,
                  Text("Create Account", style: header,),
                  10.verticalSpace,
                  Text("Glad to welcome you", style: normalText,),
                  30.verticalSpace,
                  AppTextForm(
                    validator: Validators.validateRequired,
                    controller: auth.userNameController,
                    title: "Username",
                    hintText: "Enter a username",
                  ),
                  30.verticalSpace,
                  AppTextForm(
                    validator: Validators.validateEmail,
                    textInputType: TextInputType.emailAddress,
                    controller: auth.emailController,
                    title: "Email Address",
                    hintText: "Enter your email",
                  ),
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
                  30.verticalSpace,
                  Center(child: Text(textAlign: TextAlign.center, "By clicking “Create Account”, you accept the terms and conditions", style: smallNormalText,)),
                  20.verticalSpace,
                  FilledStatelessButton(
                      buttonColor: GlobalColors.primaryColor,
                      textColor: GlobalColors.blackColor,
                      text: "Create Account",
                      onTap: () {
                      auth.callRegister(context);
                      }),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: (){
                      pushTo(context, Login());
                    },
                    child: Center(
                      child:  Text.rich(TextSpan(
                          text: "Already have an account?   ",
                          style: smallNormalText!.copyWith(color: Colors.grey),
                          children: [
                            TextSpan(
                                text: "Log in",
                                style: boldText)
                          ])),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
