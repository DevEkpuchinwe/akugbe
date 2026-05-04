import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/providers/home_provider.dart';
import 'package:akugbe/providers/profile_provider.dart';
import 'package:akugbe/screens/choose_document.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../custom_widgets/filled_stateless_button.dart';

class KYC extends ConsumerStatefulWidget {
  const KYC({super.key});

  @override
  ConsumerState createState() => _KYCState();
}

class _KYCState extends ConsumerState<KYC> with AppNavigator {
  @override
  void initState() {
    ref.read(homeProvider).clearPreviousKYC();
    super.initState();
  }

  @override
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
                "Let's verify your identity in 2 minutes",
                textAlign: TextAlign.center,
                style: normalText.copyWith(),
              ),
              20.verticalSpace,
              Text(
                "Verification of your identity is necessary to protect your account by providing the following information",
                style: smallNormalText,
                textAlign: TextAlign.center,
              ),
              30.verticalSpace,
              Text(
                "Please note before we begin",
                textAlign: TextAlign.center,
                style: smallNormalTextBolder,
              ),
              20.verticalSpace,
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.done_sharp,
                      color: GlobalColors.primaryColor,
                      weight: 100,
                      size: 30,
                    ),
                    20.horizontalSpace,
                    Expanded(
                        child: Text("Prepare a valid government issued ID"))
                  ],
                ),
              ),
              20.verticalSpace,
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.done_sharp,
                      color: GlobalColors.primaryColor,
                      weight: 100,
                      size: 30,
                    ),
                    20.horizontalSpace,
                    Expanded(
                        child: Text(
                            "Verify if the camera on your device is active and exposed"))
                  ],
                ),
              ),
              20.verticalSpace,
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.done_sharp,
                      color: GlobalColors.primaryColor,
                      weight: 100,
                      size: 30,
                    ),
                    20.horizontalSpace,
                    Expanded(
                        child: Text(
                            "Prepare to snap a selfie of your identification."))
                  ],
                ),
              ),
              30.verticalSpace,
              FilledStatelessButton(
                  buttonColor: GlobalColors.primaryColor,
                  textColor: GlobalColors.whiteColor,
                  text: "Continue",
                  onTap: () {
                    pushTo(context, const ChooseDocument());
                  })
            ],
          ),
        ),
      )),
    );
  }
}
