import 'dart:io';

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

class UploadSelfie extends ConsumerStatefulWidget {
  const UploadSelfie({super.key});

  @override
  ConsumerState createState() => _UploadSelfieState();
}

class _UploadSelfieState extends ConsumerState<UploadSelfie> with AppNavigator {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeRef = ref.watch(homeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upload Selfie",
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
            children:[
              Container(
                  width: 1.sw,
                  height: 0.3.sh,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if(homeRef.kycSelfie != null)Image.file(
                        File(homeRef.kycDocumentImage!.path),
                        fit: BoxFit.cover,
                        width: 1.sw,
                      ),
                    ],
                  )),
              30.verticalSpace,
              FilledStatelessButton(
                  buttonColor: GlobalColors.primaryColor,
                  textColor: GlobalColors.whiteColor,
                  text: "Upload",
                  onTap: () {
                    homeRef.uploadSelfie();
                    pop(context);
                  })
            ]
          ),
        ),
      )),
    );
  }
}
