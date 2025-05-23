import 'package:akugbe/screens/create_password.dart';
import 'package:akugbe/screens/verification_code.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../config/text_styles.dart';
import '../custom_widgets/filled_stateless_button.dart';
import '../custom_widgets/text_fields.dart';
import '../providers/authProvider.dart';


class VerificationSent extends ConsumerStatefulWidget {
  const VerificationSent({super.key});

  @override
  ConsumerState createState() => _VerificationSentState();
}

class _VerificationSentState extends ConsumerState<VerificationSent> with AppNavigator {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: (){
                  pop(context);
                }, icon: Icon(Icons.arrow_back_ios_new_rounded, color: GlobalColors.blackColor,)),
                30.verticalSpace,
                Center(child: Image.asset("assets/email_sent.png")),
                10.verticalSpace,
                Center(child: Text("Email Sent", style: header,)),
                20.verticalSpace,
                Center(child: Text("We have sent a verification code to your email address", style: normalText,)),
                20.verticalSpace,
                FilledStatelessButton(
                    buttonColor: GlobalColors.primaryColor,
                    textColor: GlobalColors.blackColor,
                    text: "Next",
                    onTap: () {
                       pushTo(context, const CreatePassword());
                    }),
                30.verticalSpace,
                GestureDetector(
                  onTap: (){
                    pop(context);
                  },
                  child: Center(
                    child:  Text.rich(TextSpan(
                        text: "Did not receive the email?  ",
                        style: normalText,
                        children: [
                          TextSpan(
                              text: "Resend code",
                              style: errorText)
                        ])),
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

