import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/screens/chat.dart';
import 'package:akugbe/screens/feed.dart';
import 'package:akugbe/screens/new_klik.dart';
import 'package:akugbe/screens/new_post.dart';
import 'package:akugbe/screens/profile.dart';
import 'package:akugbe/screens/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../custom_widgets/filled_stateless_button.dart';
import '../providers/authProvider.dart';
import '../utils/navigator.dart';
import 'kyc.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({super.key});

  @override
  ConsumerState createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> with AppNavigator {
  int page = 0;

  final GlobalKey _buttonKey = GlobalKey();

  void showPopupMenu(BuildContext context){
    final RenderBox renderBox = _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx, // X position
        offset.dy + size.height * 4, // Y position (above the widget)
        offset.dx + size.width,
        offset.dy,
      ),
      items: [
        PopupMenuItem(
          onTap: (){
            pushTo(context, const NewPost());
          },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/post.png"),
                10.horizontalSpace,
                Text(
                  "Post",
                  style: smallNormalText,
                )
              ],
            )),
        PopupMenuItem(
          onTap: (){
            kycRequirement();
          },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/klik.png", width: 20,),
                10.horizontalSpace,
                Text(
                  "Klik",
                  style: smallNormalText,
                )
              ],
            )),
        PopupMenuItem(
            child: GestureDetector(
              onTap:(){},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/golive.png", width: 20,),
                  10.horizontalSpace,
                  Text(
                    "Go live",
                    style: smallNormalText,
                  )
                ],
              ),
            ))
      ],
    );
  }


  void switchPage(int newPage) {
    setState(() {
      page = newPage;
    });
  }

  List<Widget> pages = [Feed(), Chat(), Wallet(), Profile()];

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: pages[page]),
            PhysicalModel(
              elevation: 12.0,
              color: GlobalColors.whiteColor,
              child: Padding(
                padding: EdgeInsets.all(15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (page != 0) {
                          switchPage(0);
                        }
                      },
                      child: Image.asset(
                        "assets/home.png",
                        color: page == 0
                            ? GlobalColors.lightBlue
                            : GlobalColors.textColorNormal,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (page != 1) {
                          switchPage(1);
                        }
                      },
                      child: Image.asset(
                        "assets/chat.png",
                        color: page == 1
                            ? GlobalColors.lightBlue
                            : GlobalColors.textColorNormal,
                      ),
                    ),
                    GestureDetector(
                      key: _buttonKey,
                      onTap: (){
                        showPopupMenu(context);
                      },
                      child: Image.asset("assets/new.png",
                          color: GlobalColors.primaryColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (page != 2) {
                          switchPage(2);
                        }
                      },
                      child: Image.asset(
                        "assets/wallet.png",
                        color: page == 2
                            ? GlobalColors.lightBlue
                            : GlobalColors.textColorNormal,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (page != 3) {
                          switchPage(3);
                        }
                      },
                      child: Image.asset(
                        "assets/profile.png",
                        color: page == 3
                            ? GlobalColors.lightBlue
                            : GlobalColors.textColorNormal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void kycRequirement() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        showDragHandle: true,
        builder: (innerContext) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return FractionallySizedBox(
              heightFactor: 0.5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Text("KYC Requirement", style: boldText,),
                    40.verticalSpace,
                    Text("KYC is required before you can create or join a Kilk"),
                    30.verticalSpace,
                    FilledStatelessButton(
                        buttonColor: GlobalColors.primaryColor,
                        textColor: GlobalColors.blackColor,
                        text: "Complete KYC",
                        onTap: () {
                        pop(innerContext);
                        pushTo(context, KYC());
                        }),
                    30.verticalSpace,
                    FilledStatelessButton(
                        buttonColor: GlobalColors.primaryColor,
                        textColor: GlobalColors.blackColor,
                        text: "Create Klik",
                        onTap: () {
                          pop(innerContext);
                          pushTo(context, NewKlik());
                        })

                  ],
                ),
              ),
            );
          });
        });
  }
}
