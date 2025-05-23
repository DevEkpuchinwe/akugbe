import 'package:akugbe/screens/create_password.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../config/text_styles.dart';
import '../custom_widgets/filled_stateless_button.dart';

class VerificationSuccessful extends ConsumerStatefulWidget {
  const VerificationSuccessful({super.key});

  @override
  ConsumerState createState() => _VerificationSuccessfulState();
}

class _VerificationSuccessfulState extends ConsumerState<VerificationSuccessful>
    with AppNavigator {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: (){
                  pop(context);
                }, icon: Icon(Icons.arrow_back_ios_new_rounded, color: GlobalColors.blackColor,)),
                30.verticalSpace,
                Center(child: Image.asset("assets/shield.png")),
                10.verticalSpace,
                Center(
                  child: Text(
                    "Verification Successful",
                    style: header,
                  ),
                ),
                20.verticalSpace,

                Center(
                  child: Text(
                    "Your email has been successfully verified,you can now reset your password.",
                    style: normalText,
                  ),
                ),
                20.verticalSpace,
                FilledStatelessButton(
                    buttonColor: GlobalColors.primaryColor,
                    textColor: GlobalColors.blackColor,
                    text: "Next",
                    onTap: () {
                      pushTo(context, const CreatePassword());
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
