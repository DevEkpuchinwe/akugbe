import 'dart:io';

import 'package:akugbe/utils/app_utils.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../config/text_styles.dart';
import '../custom_widgets/filled_stateless_button.dart';
import '../providers/authProvider.dart';

class ProfilePhoto extends ConsumerStatefulWidget {
  const ProfilePhoto({super.key});

  @override
  ConsumerState createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends ConsumerState<ProfilePhoto> with AppNavigator {
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
                IconButton(
                    onPressed: () {
                      pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: GlobalColors.blackColor,
                    )),
                30.verticalSpace,
                Text(
                  "Profile Photo",
                  style: header,
                ),
                10.verticalSpace,
                Text(
                  "Add a photo so people can recognize you.",
                  style: normalText,
                ),
                20.verticalSpace,
                Center(
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: GlobalColors.primaryColor)),
                      width: 150,
                      height: 150,
                      child: auth.profilePic == null
                          ? Icon(
                              Icons.account_circle_outlined,
                              color: GlobalColors.unactiveColor,
                              size: 150,
                            )
                          : ClipOval(
                              child: Image.file(
                              File(auth.profilePic!.path),
                              fit: BoxFit.cover,
                            ))),
                ),
                10.verticalSpace,
                Center(
                    child: Container(
                        decoration: BoxDecoration(
                          color: GlobalColors.unactiveColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            onPressed: () async {
                              var result =
                                  await AppUtils.singleImagePicker(context);
                              if (result != null) {
                                auth.selectProfilePic(context, result);
                              }
                            },
                            icon: Icon(Icons.camera_alt_outlined)))),
                40.verticalSpace,
                FilledStatelessButton(
                    buttonColor: GlobalColors.primaryColor,
                    textColor: GlobalColors.blackColor,
                    text: "Next",
                    onTap: () {
                     auth.savePhoto(context);
                    //   if(auth.profilePic != null){
                    //     pushTo(context, const Interests());
                    //   }else{
                    //     AppUtils.showErrorMessage(context, "Add Image", false, "Error");
                    //   }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
