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

class BoostPost extends ConsumerStatefulWidget {
  const BoostPost({super.key});

  @override
  ConsumerState createState() => _AdStatState();
}

class _AdStatState extends ConsumerState<BoostPost> with AppNavigator {
  double _minAge = 28;
  double _maxAge = 60;
  int _selectedGender = 0; // 0: All, 1: Male, 2: Female

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
                    "Your Audience",
                    style: normalTextBold,
                  ),
                ],
              ),
              20.verticalSpace,
              buildSelectionButton("Location"),
              20.verticalSpace,
              buildSelectionButton("Interest"),
              const SizedBox(height: 20),
              const Text(
                "Age",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SliderTheme(
                data: const SliderThemeData(
                  showValueIndicator: ShowValueIndicator.always,
                ),
                child: RangeSlider(
                  values: RangeValues(_minAge, _maxAge),
                  min: 18,
                  max: 60,
                  divisions: 42,
                  activeColor: GlobalColors.primaryColor,
                  labels: RangeLabels("${_minAge.toInt()}", "${_maxAge.toInt()}"),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _minAge = values.start;
                      _maxAge = values.end;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${_minAge.toInt()}",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  const Text("60+", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Gender",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildGenderButton("All", 0),
                  buildGenderButton("Male", 1),
                  buildGenderButton("Female", 2),
                ],
              ),
              40.verticalSpace,
              FilledStatelessButton(
                  buttonColor: GlobalColors.primaryColor,
                  textColor: GlobalColors.blackColor,
                  text: "Next",
                  onTap: () {
pushTo(context, const BoostPostBudget());
                  })
            ],
          ),
        ),
      )),
    );
  }

  Widget buildSelectionButton(String title) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.5,
      child: ListTile(
        title: Text(title, style: smallNormalTextBolder),
        trailing: const Icon(Icons.chevron_right, color: Colors.black54),
        onTap: () {},
      ),
    );
  }

  Widget buildGenderButton(String text, int value) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedGender = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: _selectedGender == value ? GlobalColors.primaryColor : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: _selectedGender == value ? Colors.white : Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
