import 'package:akugbe/screens/verification_successful.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/colors.dart';
import '../config/text_styles.dart';
import '../custom_widgets/filled_stateless_button.dart';
import '../custom_widgets/text_fields.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../providers/authProvider.dart';


class VerificationCode extends ConsumerStatefulWidget {
  const VerificationCode({super.key});

  @override
  ConsumerState createState() => _VerificationCodeState();
}

class _VerificationCodeState extends ConsumerState<VerificationCode> with AppNavigator {
  @override
  String otp = "";
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: (){
                  pop(context);
                }, icon: Icon(Icons.arrow_back_ios_new_rounded, color: GlobalColors.blackColor,)),
                30.verticalSpace,
                Center(child: Text("Verification code", style: header,)),
                10.verticalSpace,
                Center(child: Text("Enter the verification code sent to your email address", style: normalText,)),
                40.verticalSpace,
                OtpTextField(
                  numberOfFields: 4,
                  fieldWidth: 50,
                  borderColor: Colors.grey,
                  focusedBorderColor: GlobalColors.primaryColor,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                  },
                  //runs when every textfield is filled
                  onSubmit: (String code) {
                    setState(() {
                      otp = code;
                      print(code);
                    });
                  }, // end onSubmit
                ),
                30.verticalSpace,
                FilledStatelessButton(
                    buttonColor: GlobalColors.primaryColor,
                    textColor: GlobalColors.blackColor,
                    text: "Verify",
                    onTap: () {
                      print("object");
                      print(otp);
                      if(otp.isNotEmpty) {
                        print("object");
                        auth.verifyOtp(context, otp);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

