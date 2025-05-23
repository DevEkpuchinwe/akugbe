import 'package:akugbe/config/colors.dart';
import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/providers/authProvider.dart';
import 'package:akugbe/providers/profile_provider.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EngagementStat extends ConsumerStatefulWidget {
  const EngagementStat({super.key});

  @override
  ConsumerState createState() => _AdStatState();
}

class _AdStatState extends ConsumerState<EngagementStat> with AppNavigator {
  @override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((callback) {
      //  ref.read(profileProvider).callGetUserAdStat(context);
    });
  }

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
              buildEngagementChart(),
              const SizedBox(height: 20),
              const Text(
                "Post Analysis",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              buildStatBar("Views", 1000, Colors.orange, 1000),
              12.verticalSpace,
              buildStatBar("Comment", 25, Colors.blue, 100),
              12.verticalSpace,
              buildStatBar("Like", 14, Colors.green, 100),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildEngagementChart() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Total Stat",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 70,
                      sections: [
                        PieChartSectionData(
                          value: 35,
                          color: Colors.blue,
                          radius: 12,
                          title: '',
                        ),
                        PieChartSectionData(
                          value: 40,
                          color: Colors.orange,
                          radius: 12,
                          title: '',
                        ),
                        PieChartSectionData(
                          value: 25,
                          color: Colors.green,
                          radius: 12,
                          title: '',
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "25k",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "Engagement",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text("Like", style: smallNormalTextBold!.copyWith(color: Colors.blue)),
                Text("Views", style: smallNormalTextBold!.copyWith(color: Colors.orange)),
                Text("Comments", style: smallNormalTextBold!.copyWith(color: Colors.green)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatBar(String title, int value, Color color, int maxValue) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding:  EdgeInsets.all(16.h),
        child: Column(
          spacing: 12.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style:  smallNormalTextBold!.copyWith(fontSize: 14, color: Colors.black87),
                ),
                Text(
                  "$value",
                  style: smallNormalTextBold!.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: value / maxValue,
                minHeight: 8,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
