import 'package:akugbe/config/colors.dart';
import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/providers/authProvider.dart';
import 'package:akugbe/providers/profile_provider.dart';
import 'package:akugbe/screens/ad_stats.dart';
import 'package:akugbe/screens/more_profile.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_widgets/filled_stateless_button.dart';

class PostStat extends ConsumerStatefulWidget {
  const PostStat({super.key});

  @override
  ConsumerState createState() => _PostStatState();
}

class _PostStatState extends ConsumerState<PostStat> with AppNavigator {
  @override

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((callback){
    //  ref.read(profileProvider).callGetUserPostStat(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    final authRef = ref.watch(authProvider);
    final profileRef = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post Stat",
          style: normalTextBold,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
             //   pushTo(context, const MorePostStat());
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: GlobalColors.blackColor,
              ))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              buildReviewItem("People Reached", "2,235"),
              buildReviewItem("Duration", "3 days", isClickable: true),
              buildReviewItem("Budget", "10,000 NGN", isClickable: true, color: Colors.blue),
              buildReviewItem("Target Gender", "All"),
              buildReviewItem("Age Range", "18 - 54"),
              buildReviewItem("Goal", "More Followers"),
              buildReviewItem("Days Left", "2 days"),
              buildReviewItem("Status", "Running"),
              buildReviewItem("Location", "Lagos"),
              buildReviewItem("Interest", "Sport"),
              20.verticalSpace,
              FilledStatelessButton(
                  buttonColor: GlobalColors.primaryColor,
                  textColor: GlobalColors.blackColor,
                  text: "See Engagement Stats",
                  onTap: () {
                  pushTo(context, const EngagementStat());
                  }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildReviewItem(String title, String value, {bool isClickable = false, Color? color}) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: smallNormalTextBold.copyWith(fontSize: 15)
          ),
          GestureDetector(
            onTap: isClickable ? () {} : null,
            child: Text(
              value,
              style: smallNormalText
            ),
          ),
        ],
      ),
    );
  }
}
