import 'package:akugbe/config/colors.dart';
import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/custom_widgets/text_fields.dart';
import 'package:akugbe/providers/profile_provider.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> with AppNavigator {
  @override
  Widget build(BuildContext context) {
    final profileRef= ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
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
            ))
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
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
                  Positioned(
                      bottom: -10,
                      right: 1,
                      child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: GlobalColors.secondaryColor,
                              shape: BoxShape.circle),
                          child: Icon(Icons.camera_alt_rounded)))
                ],
              ),
            ),
            20.verticalSpace,
            Text(
              textAlign: TextAlign.start,
              profileRef.profileResponseModel!.data!.fullname!,
              style: boldText,
            ),
            30.verticalSpace,
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  AppTextForm(
                    controller: TextEditingController(text: "Fullname"),
                    prefixIcon: Image.asset("assets/li_user.png"),
                  ),
                  15.verticalSpace,
                  AppTextForm(
                    controller: TextEditingController(text: "Fullname"),
                    prefixIcon: Image.asset("assets/house.fill.png"),
                  ),
                  15.verticalSpace,
                  AppTextForm(
                    controller: TextEditingController(text: "Fullname"),
                    prefixIcon: Image.asset("assets/settings_phone.png"),
                  ),
                  15.verticalSpace,
                  AppTextForm(
                    controller: TextEditingController(text: "Fullname"),
                    prefixIcon: Image.asset("assets/fe_globe.png"),
                  ),
                  15.verticalSpace,
                  CustomDropdown(onChanged: (value) {
                    profileRef.selectGender(value);
                  },
                      value: profileRef.gender,
                      width: 1.sw,
                      items: ["Male", "Female"],
                      hint: Text("Gender", style: normalText,)),
                  15.verticalSpace,
                  // AppTextForm(
                  //   controller: TextEditingController(text: "Fullname"),
                  //   prefixIcon: Image.asset("assets/assistant_photo.png"),
                  // )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
