import 'package:akugbe/config/colors.dart';
import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/providers/authProvider.dart';
import 'package:akugbe/providers/profile_provider.dart';
import 'package:akugbe/screens/boost_post_budget.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_widgets/filled_stateless_button.dart';

class ReviewAd extends ConsumerStatefulWidget {
  const ReviewAd({super.key});

  @override
  ConsumerState createState() => _AdStatState();
}

class _AdStatState extends ConsumerState<ReviewAd> with AppNavigator {


  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((callback) {
      //  ref.read(profileProvider).callGetUserAdStat(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authRef = ref.watch(authProvider);
    final profileRef = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Boost Post",
          style: normalTextBold,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                //   pushTo(context, const MoreAdStat());
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

              Row(
                children: [
                   Text(
                    "Ad Summary",
                    style: smallNormalTextBolder,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildSummaryRow("3", "3 days"),
              _buildSummaryRow("Total Budget", "300 FPW"),
              _buildSummaryRow("Goal", "More Followers"),
              _buildSummaryRow("Interest", "Sport"),
              12.verticalSpace,
              Center(
                child: Text(
                  "You are spending 100 FPW each day for this Ad.",
                  textAlign: TextAlign.center,
                  style: normalText,
                ),
              ),
              20.verticalSpace,
              const Text(
                "By pressing Boost Now you agree to Akugbe Terms and Conditions.",
                style: TextStyle(fontSize: 12, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildSummaryRow(String leftText, String rightText) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leftText, style: smallNormalTextBolder),
          Text(rightText, style: normalText),
        ],
      ),
    );
  }
}
