import 'package:akugbe/config/colors.dart';
import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/providers/authProvider.dart';
import 'package:akugbe/providers/profile_provider.dart';
import 'package:akugbe/screens/review_ad.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../custom_widgets/filled_stateless_button.dart';

class BoostPostBudget extends ConsumerStatefulWidget {
  const BoostPostBudget({super.key});

  @override
  ConsumerState createState() => _AdStatState();
}

class _AdStatState extends ConsumerState<BoostPostBudget> with AppNavigator {
  double _fpw = 1000;
  int _days = 3;

  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((callback) {
      //  ref.read(profileProvider).callGetUserAdStat(context);
    });
  }

  Future<void> _pickDateRange() async {
    DateTimeRange? pickedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedRange != null) {
      setState(() {
        _selectedDateRange = pickedRange;
      });
    }
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
                    "Your Budget",
                    style: normalTextBold,
                  ),
                ],
              ),
              20.verticalSpace,
              Text(
                  "How much are you willing to spend? This will determine the number of people your post will reach with this Ad.",
                  style: normalText),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Reach",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Icon(Icons.info_outline,
                      color: Colors.blue.shade900, size: 18),
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: "1000 ~ 1500k",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              ),
              const SizedBox(height: 16),
              const Text("FPW",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${_fpw.toInt()}",
                    style: smallNormalTextBold!.copyWith(color: GlobalColors.primaryColor, fontSize: 20),
                  ),
                   Icon(Icons.edit, color: GlobalColors.primaryColor),
                ],
              ),
              Slider(
                value: _fpw,
                min: 1000,
                max: 10000,
                activeColor: GlobalColors.primaryColor,
                onChanged: (value) {
                  setState(() {
                    _fpw = value;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("1000",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Text("10000",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                   Text("Duration",
                      style: smallNormalTextBolder),
                ],
              ),
              const SizedBox(height: 6),
              Text("How long do you want this Ad to run?",
                  style: normalText),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Days",
                        style: normalText),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (_days > 1) _days--;
                            });
                          },
                        ),
                        Text("$_days",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              _days++;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              24.verticalSpace,
              GestureDetector(
                onTap: _pickDateRange,
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        color: Colors.black54, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      _selectedDateRange == null
                          ? "Select Date Range"
                          : "${DateFormat.yMMMd().format(_selectedDateRange!.start)} - ${DateFormat.yMMMd().format(_selectedDateRange!.end)}",
                      style: normalText,
                    ),
                  ],
                ),
              ),
              40.verticalSpace,
              FilledStatelessButton(
                  buttonColor: GlobalColors.primaryColor,
                  textColor: GlobalColors.blackColor,
                  text: "Next",
                  onTap: () {
                    pushTo(context, const ReviewAd());
                  })
            ],
          ),
        ),
      )),
    );
  }
}
