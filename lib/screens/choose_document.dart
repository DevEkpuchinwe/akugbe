import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/custom_widgets/text_fields.dart';
import 'package:akugbe/providers/profile_provider.dart';
import 'package:akugbe/screens/verify_identity.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../custom_widgets/filled_stateless_button.dart';

class ChooseDocument extends ConsumerStatefulWidget {
  const ChooseDocument({super.key});

  @override
  ConsumerState createState() => _ChooseDocumentState();
}

class _ChooseDocumentState extends ConsumerState<ChooseDocument>
    with AppNavigator {
  @override
  void initState() {
    super.initState();
  }

  String? document;

  Widget build(BuildContext context) {
    final profileRef = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "KYC",
          style: normalTextBold,
        ),
        leading: IconButton(
            onPressed: () {
              pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: GlobalColors.blackColor,
            )),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              20.verticalSpace,
              Image.asset("assets/kyc.png"),
              20.verticalSpace,
              Text(
                "Let's obtain your transaction verification",
                textAlign: TextAlign.center,
                style: normalText!.copyWith(),
              ),
              20.verticalSpace,
              Text(
                "Please supply the following details so that we can protect your account and help us validate your identity.",
                style: smallNormalText,
                textAlign: TextAlign.center,
              ),
              40.verticalSpace,
              CustomDropdown(
                value: document,
                  onChanged: (value) {
                    setState(() {
                      document = value;
                    });
                  },
                  items: [
                    "NIN Slip",
                    "National ID Card",
                    "National Passport",
                    "Drivers' License"
                  ],
                  hint: Text("Choose Document")),
              50.verticalSpace,
              if(document != null)    FilledStatelessButton(
                  buttonColor: GlobalColors.primaryColor,
                  textColor: GlobalColors.blackColor,
                  text: "Continue",
                  onTap: () {
pushTo(context, const VerifyIdentity());
                  })
            ],
          ),
        ),
      )),
    );
  }
}
