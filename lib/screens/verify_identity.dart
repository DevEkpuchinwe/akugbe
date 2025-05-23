import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/providers/home_provider.dart';
import 'package:akugbe/screens/kyc_successful.dart';
import 'package:akugbe/screens/upload_document.dart';
import 'package:akugbe/screens/upload_selfie.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../config/colors.dart';
import '../custom_widgets/filled_stateless_button.dart';
import '../utils/app_utils.dart';

class VerifyIdentity extends ConsumerStatefulWidget {
  const VerifyIdentity({super.key});

  @override
  ConsumerState createState() => _VerifyIdentityState();
}

class _VerifyIdentityState extends ConsumerState<VerifyIdentity>
    with AppNavigator {
  @override
  void initState() {
    super.initState();
  }

  void _snapImage() async {
    final image = await AppUtils.captureImage(context);
    if (image != null) {
      ref.read(homeProvider).kycDocumentImage = image;
      pushTo(context, const UploadDocument());
    }
  }

  void _pickImage() async {
    final image = await AppUtils.singleImagePicker(context);
    if (image != null) {
      ref.read(homeProvider).kycDocumentImage = image;
      pushTo(context, const UploadDocument());
    }
  }

  void _snapSelfie() async {
    final image =
        await AppUtils.captureImage(context, source: CameraDevice.front);
    if (image != null) {
      ref.read(homeProvider).kycSelfie = image;
      pushTo(context, const UploadSelfie());
    }
  }

  Widget build(BuildContext context) {
    final homeRef = ref.watch(homeProvider);
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
              Image.asset("assets/kyc.png", ),
              20.verticalSpace,
              Text(
                "Verify your Identity",
                textAlign: TextAlign.center,
                style: normalText!.copyWith(),
              ),
              20.verticalSpace,
              Text(
                "Verification of your identity is necessary to protect your account by providing the following information",
                style: smallNormalText,
                textAlign: TextAlign.center,
              ),
              40.verticalSpace,
              GestureDetector(
                onTap: () {
                  chooseUploadType(_snapImage, _pickImage, () {});
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Image.asset("assets/is_card.png", width: 20,),
                      20.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicHeight(
                              child: Expanded(
                                  child: Text(
                                "Identity Document",
                                style: smallNormalTextBolder,
                              )),
                            ),
                            IntrinsicHeight(
                              child: Expanded(
                                  child: Text(
                                "Tap to take a photo of your ID",
                                style: smallNormalText,
                              )),
                            )
                          ],
                        ),
                      ),
                      20.horizontalSpace,
                      if (homeRef.idUploaded)
                        Icon(
                          Icons.done_sharp,
                          color: GlobalColors.primaryColor,
                          weight: 100,
                          size: 30,
                        ),
                    ],
                  ),
                ),
              ),
              20.verticalSpace,
              GestureDetector(
                onTap: _snapSelfie,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/scanner.png", width: 20,),
                      20.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicHeight(
                              child: Expanded(
                                  child: Text("Face Verification",
                                      style: smallNormalTextBolder)),
                            ),
                            IntrinsicHeight(
                              child: Expanded(
                                  child: Text(
                                "Tap to snap a selfie",
                                style: smallNormalText,
                              )),
                            )
                          ],
                        ),
                      ),
                      20.horizontalSpace,
                      if (homeRef.selfieUploaded)
                        Icon(
                          Icons.done_sharp,
                          color: GlobalColors.primaryColor,
                          weight: 100,
                          size: 30,
                        ),
                    ],
                  ),
                ),
              ),
              40.verticalSpace,
              if (homeRef.selfieUploaded && homeRef.idUploaded)
                FilledStatelessButton(
                    buttonColor: GlobalColors.primaryColor,
                    textColor: GlobalColors.whiteColor,
                    text: "Verify",
                    onTap: () {
                      pushTo(context, const KYCSuccessful());
                    })
            ],
          ),
        ),
      )),
    );
  }

  void chooseUploadType(Function camera, Function gallery, Function file) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        showDragHandle: true,
        builder: (innerContext) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return FractionallySizedBox(
              heightFactor: 0.3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose Source",
                      style: boldText,
                    ),
                    20.verticalSpace,
                    TextButton(
                        onPressed: () {
                          pop(innerContext);
                          camera.call();
                        },
                        child: Text(
                          textAlign: TextAlign.start,
                          "Camera",
                          style: smallNormalText,
                        )),
                    TextButton(
                        onPressed: () {
                          pop(innerContext);
                          gallery.call();
                        },
                        child: Text(
                          textAlign: TextAlign.start,
                          "Gallery",
                          style: smallNormalText,
                        )),
                    TextButton(
                        onPressed: () {
                          pop(innerContext);
                          file.call();
                        },
                        child: Text(
                          textAlign: TextAlign.start,
                          "File             ",
                          style: smallNormalText,
                        ))
                  ],
                ),
              ),
            );
          });
        });
  }
}
