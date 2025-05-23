import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/providers/profile_provider.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';

class FAQ extends ConsumerStatefulWidget {
  const FAQ({super.key});

  @override
  ConsumerState createState() => _FAQState();
}

class _FAQState extends ConsumerState<FAQ> with AppNavigator {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final profileRef = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Frequently Asked Questions",
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...[
                FAQItem("What is the purpose of this app?",
                    "This app helps users to chat and network with people world wide")
              ].map((faqItem) => FAQExpansionItem(faq: faqItem)),
              20.verticalSpace,
              Text("Need more information?", style: smallNormalText ,),
              20.verticalSpace,
              Text("Can't find the answer you're looking for?", style: smallNormalText ,),
              10.verticalSpace,
              Text("Please chat to our friendly team.", style: smallNormalText ,),
              30.verticalSpace,
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: GlobalColors.primaryColor),
                  child: IntrinsicWidth(
                    child: Text(
                      "Get in touch",
                      style:
                      normalText!.copyWith(color: GlobalColors.whiteColor),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      )),
    );
  }
}

class FAQExpansionItem extends StatelessWidget {
  final FAQItem faq;

  const FAQExpansionItem({super.key, required this.faq});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: ExpansionTile(
          childrenPadding: const EdgeInsets.all(0),
          tilePadding: const EdgeInsets.all(0),
          title: Text(faq.question, style: boldText),
          children: [
            Text(
              faq.answer,
              style: normalText,
            )
          ],
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  const FAQItem(this.question, this.answer);
}
