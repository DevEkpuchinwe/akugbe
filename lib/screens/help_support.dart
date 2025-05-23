import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/providers/profile_provider.dart';
import 'package:akugbe/screens/faq.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';

class HelpSupport extends ConsumerStatefulWidget {
  const HelpSupport({super.key});

  @override
  ConsumerState createState() => _HelpSupportState();
}

class _HelpSupportState extends ConsumerState<HelpSupport> with AppNavigator {
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
          "Help & Support",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi ${profileRef.profileResponseModel?.data?.fullname?.split(" ").first ?? "" } 👋🏽",
                style: header,
              ),
              5.verticalSpace,
              Text(
                "How can we be of help? ",
                style: header,
              ),
              20.verticalSpace,
              ListTile(
                title: Text(
                  "Quick Link",
                  style: boldText,
                ),
              ),
              10.verticalSpace,
              ListTile(
                leading: Image.asset("assets/phonelink.png"),
                title: Text(
                  "Chat with SwiftSend chat assistant",
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
                leading: Image.asset("assets/contact_phone.png"),
                title: Text(
                  "Reach out",
                  style: smallNormalText,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color.fromRGBO(100, 116, 139, 1),
                  size: 20,
                ),
              ),
              10.verticalSpace,
              ListTile(
                title: Text(
                  "More",
                  style: boldText,
                ),
              ),
              5.verticalSpace,
              ListTile(
                leading: Image.asset("assets/stars.png"),
                title: Text(
                  "Rate & Review",
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
                onTap: (){
                  pushTo(context, const FAQ());
                },
                leading: Image.asset("assets/question.png"),
                title: Text(
                  "More FAQs",
                  style: smallNormalText,
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
