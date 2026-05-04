import 'package:akugbe/screens/reset_password.dart';
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


class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> with AppNavigator {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: SingleChildScrollView(
            child: Form(
              key: auth.loginKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  30.verticalSpace,
                  Center(
                    child: Image.asset("assets/logo.png"),
                  ),
                  30.verticalSpace,
                  Text("Login", style: header,),
                  10.verticalSpace,
                  Text("Glad to see you back", style: normalText,),
                  30.verticalSpace,
                  AppTextForm(
                    title: "Email",
                    hintText: "Email",
                    controller: auth.emailController,
                    validator: Validators.validateEmail,
                  ),
                  30.verticalSpace,
                  PasswordTextForm(controller: auth.passwordController,
                      text: "Password",
                      textInputType: TextInputType.text,
                      title: "Password"),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){
                        pushTo(context, const ResetPassword());
                      }, child:  Text("Forgot Password? ", style: boldText)),
                    ],
                  ),
                  40.verticalSpace,
                  FilledStatelessButton(
                      buttonColor: GlobalColors.primaryColor,
                      textColor: GlobalColors.blackColor,
                      text: "Login",
                      onTap: () {
                      auth.callLogin(context);
                      }),
                  30.verticalSpace,
                  GestureDetector(
                    onTap: (){
                      pop(context);
                    },
                    child: Center(
                      child:  Text.rich(TextSpan(
                          text: "New here? ",
                          style: smallNormalText.copyWith(fontSize: 15, color: Colors.grey),
                          children: [
                            TextSpan(
                                text: "Create Account",
                                style: errorText.copyWith(fontWeight: FontWeight.bold))
                          ])),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

