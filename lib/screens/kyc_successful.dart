import 'package:akugbe/screens/feed.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../config/text_styles.dart';
import '../custom_widgets/filled_stateless_button.dart';

class KYCSuccessful extends ConsumerStatefulWidget {
  const KYCSuccessful({super.key});

  @override
  ConsumerState createState() => _KYCSuccessfulState();
}

class _KYCSuccessfulState extends ConsumerState<KYCSuccessful>
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
                IconButton(
                    onPressed: () {
                      pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: GlobalColors.blackColor,
                    )),
                30.verticalSpace,
                Center(
                  child: Text(
                    "KYC Successful",
                    style: header,
                  ),
                ),
                40.verticalSpace,
                Center(child: Image.asset("assets/email_sent.png")),
                40.verticalSpace,
                Center(
                  child: Text(
                    "Congratulations your identity successfully matched",
                    style: normalText,
                  ),
                ),
                20.verticalSpace,
                FilledStatelessButton(
                    buttonColor: GlobalColors.primaryColor,
                    textColor: GlobalColors.blackColor,
                    text: "Next",
                    onTap: () {
                      pushAndRemoveAllPreviousScreens(context, const Feed());
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
