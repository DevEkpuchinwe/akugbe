import 'package:akugbe/api_response_models/klik_model.dart';
import 'package:akugbe/config/colors.dart';
import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/screens/boost_post.dart';
import 'package:akugbe/screens/search.dart';
import 'package:akugbe/utils/app_utils.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'klik_details.dart';
import 'other_profile.dart';

class Feed extends ConsumerStatefulWidget {
  const Feed({super.key});

  @override
  ConsumerState createState() => _FeedState();
}

class _FeedState extends ConsumerState<Feed>
    with AppNavigator, TickerProviderStateMixin {
  late TabController tabController;
  final GlobalKey _buttonKey = GlobalKey();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  final List<Klik> kliks = [
    Klik(
      name: "Tech Innovators",
      location: "San Francisco",
      maxPeople: 20,
      privacy: "Public",
      description: "A group for tech enthusiasts.",
      totalAmount: 5000.0,
      minAmount: 100.0,
      gender: "Any",
      startDate: "2025-04-01",
      endDate: "2025-12-01",
      imageUrl: "https://via.placeholder.com/150",
    ),
    Klik(
      name: "Fitness Club",
      location: "New York",
      maxPeople: 15,
      privacy: "Private",
      description: "A group for fitness lovers.",
      totalAmount: 3000.0,
      minAmount: 50.0,
      gender: "Male",
      startDate: "2025-05-01",
      endDate: "2025-11-30",
      imageUrl: "https://via.placeholder.com/150",
    ),
  ];

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
            child: GestureDetector(
              onTap:(){},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/download_n.png"),
                  10.horizontalSpace,
                  Text(
                    "Download",
                    style: smallNormalText,
                  )
                ],
              ),
            )),
        PopupMenuItem(
            child: GestureDetector(
              onTap:(){},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/favourite.png", width: 20,),
                  10.horizontalSpace,
                  Text(
                    "Save to my favourite",
                    style: smallNormalText,
                  )
                ],
              ),
            )),
        PopupMenuItem(
            child: GestureDetector(
              onTap:(){},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/comment_n.png", width: 20,),
                  10.horizontalSpace,
                  Text(
                    "Comment",
                    style: smallNormalText,
                  )
                ],
              ),
            )),
        PopupMenuItem(
            child: GestureDetector(
              onTap:(){},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/share.png", width: 20,),
                  10.horizontalSpace,
                  Text(
                    "Share",
                    style: smallNormalText,
                  )
                ],
              ),
            )),
        PopupMenuItem(
            child: GestureDetector(
              onTap:(){},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/report.png", width: 20,),
                  10.horizontalSpace,
                  Text(
                    "Report this",
                    style: smallNormalText,
                  )
                ],
              ),
            )),
        PopupMenuItem(
            child: GestureDetector(
              onTap:(){
                pushTo(context, const BoostPost());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                 Icon(Icons.auto_graph_rounded, size: 20, color: GlobalColors.blackColor,),
                  10.horizontalSpace,
                  Text(
                    "Boost Post",
                    style: smallNormalText,
                  )
                ],
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/logo.png",
            width: 100,
          ),
          bottom: TabBar( labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: "All Feeds"),
              Tab(text: "All Kliks"),
            ],),
          actions: [
            Row(
              children: [
                GestureDetector(
                    onTap:(){
                      pushTo(context, const Search());
                    },
                    child: Image.asset("assets/Search.png")),
                30.horizontalSpace,
                Image.asset("assets/Bell_light.png")
              ],
            )
          ],
        ),
        body: TabBarView(children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap:(){
                                  pushTo(context, const OtherProfile());
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    width: 40,
                                    height: 40,
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                          "https://picsum.photos/id/237/200/300"),
                                    )),
                              ),
                              20.horizontalSpace,
                              Text(
                                "Evelinead",
                                style: boldText,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              "12h",
                              style: smallNormalText!.copyWith(color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    ),
                    5.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "#Art #Story #Friends",
                        style: normalText!.copyWith(color: GlobalColors.lightBlue),
                      ),
                    ),
                    5.verticalSpace,
                    CachedNetworkImage(
                        width: 1.sw,
                        fit: BoxFit.fitWidth,
                        imageUrl: "https://picsum.photos/id/237/200/300"),
                    20.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: GlobalColors.primaryColor),
                              child: Row(
                                children: [
                                  Text(
                                    AppUtils.formatAmount("500000"),
                                    style: normalTextBold!
                                        .copyWith(color: GlobalColors.blackColor, fontSize: 10.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset("assets/love.png", width: 15, color: GlobalColors.blackColor,),
                                5.horizontalSpace,
                                Text(
                                  "568",
                                  style: normalText!.copyWith(fontSize: 11.sp),
                                ),
                                10.horizontalSpace,
                                Image.asset("assets/comment_n.png", width: 15, color: GlobalColors.blackColor),
                                5.horizontalSpace,
                                Text(
                                  "568",
                                  style: normalText!.copyWith(fontSize: 11.sp),
                                ),
                                10.horizontalSpace,
                                Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: GlobalColors.blackColor, size: 15,
                                ),
                                5.horizontalSpace,
                                Text(
                                  "568",
                                  style: normalText!.copyWith(fontSize: 11.sp),
                                ),
                                10.horizontalSpace,
                                GestureDetector(
                                    key: _buttonKey,
                                    onTap: () {
                                      showPopupMenu(context);
                                    },
                                    child: Icon(Icons.more_vert_rounded))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                // TabBar(
                //     controller: tabController,
                //     indicatorWeight: 1,
                //     unselectedLabelStyle: smallNormalTextBolder!
                //         .copyWith(color: Color.fromRGBO(154, 154, 154, 1)),
                //     labelStyle: smallNormalTextBolder,
                //     indicatorSize: TabBarIndicatorSize.label,
                //     indicatorColor: GlobalColors.primaryColor,
                //     dividerColor: Colors.transparent,
                //     tabs: [
                //       Tab(
                //         text: "All Feeds",
                //       ),
                //       Tab(
                //         text: "All Kliks",
                //       ),
                //     ]),
                // TabBarView(controller: tabController, children: [
                //   Text("data"),
                //   Text("data")
                //   // ListView.builder(
                //   //   shrinkWrap: true,
                //   //     itemCount: 1,
                //   //     itemBuilder: (context, index) {
                //   //       return Column(
                //   //         children: [
                //   //           Text("data"),
                //   //           Row(
                //   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   //             children: [
                //   //               Text("data"),
                //   //               Container(
                //   //                   decoration: BoxDecoration(
                //   //                     shape: BoxShape.circle,
                //   //                   ),
                //   //                   width: 65,
                //   //                   height: 65,
                //   //                   child: ClipOval(
                //   //                     child: CachedNetworkImage(
                //   //                         fit: BoxFit.cover,
                //   //                         imageUrl:
                //   //                             "https://picsum.photos/id/237/200/300"),
                //   //                   ))
                //   //             ],
                //   //           )
                //   //         ],
                //   //       );
                //   //     })
                // ])
              ],
            ),
          ),
          ListView.builder(
            itemCount: kliks.length,
            itemBuilder: (context, index) {
              final klik = kliks[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(klik.imageUrl),
                  ),
                  title: Text(klik.name, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Min Contribution: \$${klik.minAmount.toStringAsFixed(2)}"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KlikDetailScreen(klik: klik),
                      ),
                    );
                  },
                ),
              );
            },
          ),

        ])
      ),
    );
  }
}
