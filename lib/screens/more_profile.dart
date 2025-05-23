import 'package:akugbe/config/colors.dart';
import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/providers/authProvider.dart';
import 'package:akugbe/screens/ad_analysis.dart';
import 'package:akugbe/screens/edit_profile.dart';
import 'package:akugbe/screens/help_support.dart';
import 'package:akugbe/screens/kyc.dart';
import 'package:akugbe/screens/login.dart';
import 'package:akugbe/screens/privacy_policy.dart';
import 'package:akugbe/screens/settings.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_widgets/filled_stateless_button.dart';

class MoreProfile extends ConsumerStatefulWidget {
  const MoreProfile({super.key});

  @override
  ConsumerState createState() => _MoreProfileState();
}

class _MoreProfileState extends ConsumerState<MoreProfile> with AppNavigator {
  @override
  Widget build(BuildContext context) {
    final authRef = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
          title: Text(
            "Profile",
            style: normalTextBold,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: GlobalColors.blackColor,
              ))),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          children: [
            Center(
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: GlobalColors.primaryColor),
                    shape: BoxShape.circle,
                  ),
                  width: 90,
                  height: 90,
                  child: ClipOval(
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: "https://picsum.photos/id/237/200/300"),
                  )),
            ),
            20.verticalSpace,
            Text(
              textAlign: TextAlign.start,
              authRef.loginResponse!.data!.user!.fullname!,
              style: boldText,
            ),
            30.verticalSpace,
            GestureDetector(
              onTap: (){
                pushTo(context, const HelpSupport());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: GlobalColors.primaryColor),
                child: IntrinsicWidth(
                  child: Row(
                    children: [
                      Image.asset("assets/help.png"),
                      10.horizontalSpace,
                      Text(
                        "Help/Support",
                        style:
                            normalText!.copyWith(color: GlobalColors.whiteColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
            30.verticalSpace,
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 3, bottom: 3),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(243, 243, 243, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      onTap: () {
                      //  pushTo(context, const EditProfile());
                      },
                      leading: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(112, 126, 255, 0.1)),
                          child: Image.asset("assets/li_user.png")),
                      title: Text(
                        "Edit Profile",
                        style: smallNormalTextBolder,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color.fromRGBO(100, 116, 139, 1),
                        size: 20,
                      ),
                    ),
                  ),
                  15.verticalSpace,
                  Container(
                    padding: EdgeInsets.only(top: 3, bottom: 3),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(243, 243, 243, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      onTap: (){
                        pushTo(context, const PrivacyPolicy());
                      },
                      leading: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(112, 126, 255, 0.1)),
                          child: Image.asset("assets/edit_road.png")),
                      title: Text(
                        "Privacy Policy",
                        style: smallNormalTextBolder,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color.fromRGBO(100, 116, 139, 1),
                        size: 20,
                      ),
                    ),
                  ),
                  15.verticalSpace,
                  Container(
                    padding: EdgeInsets.only(top: 3, bottom: 3),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(243, 243, 243, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      onTap: (){
                        pushTo(context, const KYC());
                      },
                      leading: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(112, 126, 255, 0.1)),
                          child: Image.asset("assets/edit_road.png")),
                      title: Text(
                        "Identity Verification",
                        style: smallNormalTextBolder,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color.fromRGBO(100, 116, 139, 1),
                        size: 20,
                      ),
                    ),
                  ),
                  15.verticalSpace,
                  GestureDetector(
                    onTap: (){
                      pushTo(context, const PostStat());
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 3, bottom: 3),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(243, 243, 243, 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        leading: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(112, 126, 255, 0.1)),
                            child: Image.asset("assets/enhanced_encryption.png")),
                        title: Text(
                          "Ads",
                          style: smallNormalTextBolder,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color.fromRGBO(100, 116, 139, 1),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  15.verticalSpace,
                  Container(
                    padding: EdgeInsets.only(top: 3, bottom: 3),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(243, 243, 243, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(112, 126, 255, 0.1)),
                          child: Image.asset("assets/enhanced_encryption.png")),
                      title: Text(
                        "Security",
                        style: smallNormalTextBolder,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color.fromRGBO(100, 116, 139, 1),
                        size: 20,
                      ),
                    ),
                  ),
                  15.verticalSpace,
                  Container(
                    padding: EdgeInsets.only(top: 3, bottom: 3),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(243, 243, 243, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      onTap: (){
                        pushTo(context, const Settings());
                      },
                      leading: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(112, 126, 255, 0.1)),
                          child: Image.asset("assets/Settings.png")),
                      title: Text(
                        "Settings",
                        style: smallNormalTextBolder,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color.fromRGBO(100, 116, 139, 1),
                        size: 20,
                      ),
                    ),
                  ),
                  15.verticalSpace,
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(243, 243, 243, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      onTap: (){
                        showModalBottomSheet(
                            useSafeArea: true,
                            showDragHandle: true,
                            isScrollControlled: true,
                            isDismissible: false,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  topLeft: Radius.circular(40),
                                )),
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Logout", style: normalTextBold,),
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 5),
                                    child: Divider(
                                      color: GlobalColors.unactiveColor,
                                      thickness: 1,
                                    ),
                                  ),
                                  Text(
                                    "Are you sure you want to log out?",
                                    style: normalText,),
                                  IntrinsicHeight(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 24, horizontal: 16),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                              },
                                              child:FilledStatelessButton(
                                                  buttonColor: GlobalColors.whiteColor,
                                                  textColor: GlobalColors.blackColor,
                                                  text: "Cancel",
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  }),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 24,
                                          ),
                                          Expanded(
                                            child: FilledStatelessButton(
                                                buttonColor: GlobalColors.primaryColor,
                                                textColor: GlobalColors.whiteColor,
                                                text: "Logout",
                                                onTap: () {
                                                  pushAndRemoveAllPreviousScreens(context, Login());
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                      leading: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(112, 126, 255, 0.1)),
                          child: Image.asset("assets/majesticons_logout.png")),
                      title: Text(
                        "Logout",
                        style: smallNormalTextBolder,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color.fromRGBO(100, 116, 139, 1),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
