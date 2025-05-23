import 'package:akugbe/screens/create_account.dart';
import 'package:akugbe/screens/login.dart';
import 'package:akugbe/screens/wallet.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../config/colors.dart';
import '../config/text_styles.dart';
import '../custom_widgets/filled_stateless_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding extends ConsumerStatefulWidget {
  const Onboarding({super.key});

  @override
  ConsumerState createState() => _OnboardingState();
}

class _OnboardingState extends ConsumerState<Onboarding>  with AppNavigator{
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: CarouselSlider(
                    options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        autoPlay: true,
                        enlargeFactor: 0.2,
                        height: 0.6.sh),
                    items: <OnboardingImages>[
                      const OnboardingImages(
                          "assets/screen_1.png",
                          "Welcome to Akugbe! 🎉 Discover, connect, and share your world like never before!"),
                      const OnboardingImages(
                          "assets/scrren_2.png",
                          "Join the conversation! 🗨️ Create, share, and discover your community today!"),
                      const OnboardingImages(
                          "assets/screen_3.png",
                          "Your journey starts here! 🚀 Build your profile and connect today.")
                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 35.w),
                            child: Column(
                              children: [
                                10.verticalSpace,
                                Image.asset(
                                  i.image,
                                  height: 0.5.sh,
                                ),
                                15.verticalSpace,
                                Text(
                                  i.message,
                                  textAlign: TextAlign.center,
                                  style: smallNormalTextBold,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                IntrinsicWidth(
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                        color: GlobalColors.unactiveColor,
                        borderRadius: BorderRadius.all(Radius.circular(15.r))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...[0, 1, 2].map((index) {
                          return Container(
                            width: 5,
                            height: 5,
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            margin: EdgeInsets.symmetric(horizontal: 2.w),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: currentPage == index
                                    ? GlobalColors.orangeColor
                                    : Colors.grey),
                          );
                        })
                      ],
                    ),
                  ),
                ),
                40.verticalSpace,
                FilledStatelessButton(
                    buttonColor: GlobalColors.primaryColor,
                    textColor: GlobalColors.blackColor,
                    text: "Get Started",
                    onTap: () {
                     pushTo(context, const CreateAccount());
                    }),
                30.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingImages {
  final String image;
  final String message;

  const OnboardingImages(this.image, this.message);
}
