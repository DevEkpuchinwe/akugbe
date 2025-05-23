import 'package:akugbe/providers/authProvider.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../config/text_styles.dart';
import '../custom_widgets/filled_stateless_button.dart';

class Interests extends ConsumerStatefulWidget {
  const Interests({super.key});

  @override
  ConsumerState createState() => _InterestsState();
}

class _InterestsState extends ConsumerState<Interests> with AppNavigator {
  @override
  Widget build(BuildContext context) {
    final authProv = ref.watch(authProvider);
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
                  "Interests",
                  style: header,
                ),
                10.verticalSpace,
                Text(
                  "What are you interested in? Pick a few to personalize your experience.",
                  style: normalText,
                ),
                30.verticalSpace,
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: authProv.interests.map((interest) {
                    return ChoiceChip(
                      label: Text(interest),
                      selected: authProv.selectedInterests.contains(interest),
                      onSelected: (isSelected) =>
                          authProv.toggleInterest(interest),
                      selectedColor: Colors.blue.shade200,
                      backgroundColor: Colors.grey.shade200,
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                Text(
                  "Selected Interests:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: authProv.selectedInterests
                      .map((interest) => Chip(
                            label: Text(interest),
                            backgroundColor: Colors.blue.shade100,
                            deleteIcon: Icon(Icons.cancel),
                            onDeleted: () {
                              authProv.toggleInterest(interest);
                            },
                          ))
                      .toList(),
                ),
                40.verticalSpace,
                FilledStatelessButton(
                    buttonColor: GlobalColors.primaryColor,
                    textColor: GlobalColors.blackColor,
                    text: "Complete",
                    onTap: () {
                     authProv.saveInterests(context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
