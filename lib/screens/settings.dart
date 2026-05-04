import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/providers/profile_provider.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> with AppNavigator {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileRef = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: normalTextBold,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/Settings.png"),
                  5.horizontalSpace,
                  Text(
                    "Account Settings",
                    style: boldText,
                  ),
                ],
              ),
              10.verticalSpace,
              ListTile(
                title: Text(
                  "Freeze Account",
                  style: smallNormalTextBolder,
                ),
                subtitle: Text(
                  "Temporarily Make Your Account Inactive",
                  style: smallNormalText,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color.fromRGBO(100, 116, 139, 1),
                  size: 20,
                ),
              ),
              5.verticalSpace,
              ListTile(
                title: Text(
                  "Change Password",
                  style: smallNormalTextBolder,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color.fromRGBO(100, 116, 139, 1),
                  size: 20,
                ),
              ),
              5.verticalSpace,
              ListTile(
                title: Text(
                  "Privacy",
                  style: smallNormalTextBolder,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color.fromRGBO(100, 116, 139, 1),
                  size: 20,
                ),
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/Notification Icon.png"),
                  5.horizontalSpace,
                  Text(
                    "Notification",
                    style: boldText,
                  ),
                ],
              ),
              10.verticalSpace,
              ListTile(
                title: Text(
                  "Notification",
                  style: smallNormalTextBolder,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color.fromRGBO(100, 116, 139, 1),
                  size: 20,
                ),
              ),
              5.verticalSpace,
              ListTile(
                title: Text(
                  "Enable Login Authentication",
                  style: smallNormalTextBolder,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color.fromRGBO(100, 116, 139, 1),
                  size: 20,
                ),
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/other_settings.png"),
                  5.horizontalSpace,
                  Text(
                    "Other",
                    style: boldText,
                  ),
                ],
              ),
              10.verticalSpace,
              ListTile(
                title: Text(
                  "Dark Mode",
                  style: smallNormalTextBolder,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color.fromRGBO(100, 116, 139, 1),
                  size: 20,
                ),
              ),
              ListTile(
                title: Text(
                  "Language",
                  style: smallNormalTextBolder,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color.fromRGBO(100, 116, 139, 1),
                  size: 20,
                ),
              ),
              ListTile(
                title: Text(
                  "Region",
                  style: smallNormalTextBolder,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color.fromRGBO(100, 116, 139, 1),
                  size: 20,
                ),
              ),

            ],
          ),
        ),
      )),
    );
  }
}
