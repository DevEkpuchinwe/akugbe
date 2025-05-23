import 'package:akugbe/config/colors.dart';
import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/providers/authProvider.dart';
import 'package:akugbe/providers/profile_provider.dart';
import 'package:akugbe/screens/more_profile.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> with AppNavigator {
  @override

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((callback){
      ref.read(profileProvider).callGetUserProfile(context);
    });
  }
  Widget build(BuildContext context) {
    final authRef = ref.watch(authProvider);
    final profileRef = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: normalTextBold,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                pushTo(context, const MoreProfile());
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
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    width: 65,
                    height: 65,
                    child: ClipOval(
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "https://picsum.photos/id/237/200/300"),
                    )),
                20.horizontalSpace,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        profileRef.profileResponseModel?.data?.fullname ?? "",
                        style: boldText,
                      ),
                      3.verticalSpace,
                      Text(
                        textAlign: TextAlign.start,
                        "@${profileRef.profileResponseModel?.data?.username ?? ""}",
                        style: normalText,
                      ),
                      3.verticalSpace,
                      Text(
                          textAlign: TextAlign.start,
                          profileRef.profileResponseModel?.data?.email ?? "")
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: GlobalColors.primaryColor),
                    child: Text(
                      "Edit",
                      style: smallNormalTextBolder!
                          .copyWith(color: GlobalColors.whiteColor),
                    ),
                  ),
                )
              ],
            ),
            15.verticalSpace,
            PhysicalModel(
              color: Colors.white,
              elevation: 1,
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 45, vertical: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${profileRef.profileResponseModel?.data?.noOfPosts ?? ""}",
                          style: boldText,
                        ),
                        Text(
                          "Posts",
                          style: smallNormalText!.copyWith(
                              color: Color.fromRGBO(154, 154, 154, 1)),
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${profileRef.profileResponseModel?.data?.noOfKliks ?? ""}",
                          style: boldText,
                        ),
                        Text(
                          "Kliks",
                          style: smallNormalText!.copyWith(
                              color: Color.fromRGBO(154, 154, 154, 1)),
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${profileRef.profileResponseModel?.data?.followers ?? ""}",
                          style: boldText,
                        ),
                        Text(
                          "Followers",
                          style: smallNormalText!.copyWith(
                              color: Color.fromRGBO(154, 154, 154, 1)),
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${profileRef.profileResponseModel?.data?.following ?? ""}",
                          style: boldText,
                        ),
                        Text(
                          "Following",
                          style: smallNormalText!.copyWith(
                              color: Color.fromRGBO(154, 154, 154, 1)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            15.verticalSpace,
            DefaultTabController(
              length: 2,
              child: TabBar(
                  indicatorWeight: 1,
                  unselectedLabelStyle: smallNormalTextBolder!
                      .copyWith(color: Color.fromRGBO(154, 154, 154, 1)),
                  labelStyle: smallNormalTextBolder,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: GlobalColors.primaryColor,
                  tabs: [
                    Tab(
                      text: "Posts",
                    ),
                    Tab(
                      text: "Kliks",
                    )
                  ]),
            )
          ],
        ),
      )),
    );
  }
}
