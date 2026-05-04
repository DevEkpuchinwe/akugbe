import 'package:akugbe/screens/individual_chat.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../config/text_styles.dart';

class Chat extends ConsumerStatefulWidget {
  const Chat({super.key});

  @override
  ConsumerState createState() => _ChatState();
}

class _ChatState extends ConsumerState<Chat> with AppNavigator {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          "Chat",
          style: normalTextBold,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            10.verticalSpace,
            TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: GlobalColors.blackColor,
                  ),
                  hintStyle: normalTextPrimaryColor
                      .copyWith(color: Colors.grey),
                  hintText: "Search messages",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Adjust this value for more rounding
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent, width: 2),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(0),
                  fillColor: Colors.grey.shade200
                  // Removes default underline
                  ),
            ),
            10.verticalSpace,
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        pushTo(context, const IndividualChat());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: Row(
                          children: [
                            Container(
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
                            10.horizontalSpace,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Adeniyi Deborah",
                                  style: normalText,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                5.verticalSpace,
                                Text("Yeah, it's really good", style: smallNormalTextBold, textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis)
                              ],
                            )),
                            10.horizontalSpace,
                            Text("9:56 AM", style: smallNormalText.copyWith(color: Colors.grey),)
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      )),
    );
  }
}
