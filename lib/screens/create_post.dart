import 'package:akugbe/config/colors.dart';
import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/providers/home_provider.dart';
import 'package:akugbe/screens/feed.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_widgets/filled_stateless_button.dart';

class CreatePost extends ConsumerStatefulWidget {
  const CreatePost({super.key});

  @override
  ConsumerState createState() => _CreatePostState();
}

class _CreatePostState extends ConsumerState<CreatePost> with AppNavigator {
  @override
  Widget build(BuildContext context) {
    final homeRef = ref.watch(homeProvider);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Create Post",
            style: normalTextBold,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: GlobalColors.blackColor,
              ))),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        width: 30,
                        height: 30,
                        child: ClipOval(
                          child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: "https://picsum.photos/id/237/200/300"),
                        )),
                    10.horizontalSpace,
                    Flexible(
                      child: Column(
                        children: [
                          TextFormField(
                            style: normalText!
                                .copyWith(color: GlobalColors.blackColor),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            // expands: true,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(0),
                              hintStyle: normalTextPrimaryColor!.copyWith(
                                  color: Color.fromRGBO(196, 196, 196, 1)),
                              hintText: "Tell your story...",
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.horizontalSpace,
                    GestureDetector(
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (homeRef.editedImageToPost != null)
                                Image.memory(
                                  homeRef.editedImageToPost!,
                                  fit: BoxFit.cover,
                                ),
                              if (homeRef.newVideoThumbnail != null)
                                Image.memory(
                                  homeRef.newVideoThumbnail!,
                                  fit: BoxFit.cover,
                                ),
                              if (homeRef.newVideoThumbnail != null) Icon(Icons.play_circle_fill,
                                  size: 15, color: Colors.white)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 0.8,
              ),
              10.verticalSpace,
              GestureDetector(
                onTap: () {
                  showLocationList();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on_outlined),
                    10.horizontalSpace,
                    Text(
                      "Port Harcourt, Nigeria",
                      style: normalText,
                    )
                  ],
                ),
              ),
              10.verticalSpace,
              Divider(
                thickness: 0.8,
              ),
              10.verticalSpace,
              GestureDetector(
                onTap: () {
                  showFriendsList();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.people_rounded),
                    10.horizontalSpace,
                    Text(
                      "Tag Friends",
                      style: normalText,
                    ),
                    Expanded(
                        child: Text(
                      "10 friends",
                      textAlign: TextAlign.end,
                      style: smallNormalTextBolder,
                    ))
                  ],
                ),
              ),
              10.verticalSpace,
              Divider(
                thickness: 0.8,
              ),
              40.verticalSpace,
              FilledStatelessButton(
                  buttonColor: GlobalColors.primaryColor,
                  textColor: GlobalColors.blackColor,
                  text: "Post",
                  onTap: () {
                    pushAndRemoveAllPreviousScreens(context, const Feed());
                  })
            ],
          ),
        ),
      )),
    );
  }

  void showFriendsList() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        showDragHandle: true,
        builder: (innerContext) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return FractionallySizedBox(
                heightFactor: 0.7, child: TagFriendsWidget());
          });
        });
  }

  void showLocationList() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        showDragHandle: true,
        builder: (innerContext) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return FractionallySizedBox(
                heightFactor: 0.7, child: LocationListWidget());
          });
        });
  }
}

class TagFriendsWidget extends ConsumerStatefulWidget {
  const TagFriendsWidget({super.key});

  @override
  ConsumerState createState() => _TagFriendsWidgetState();
}

class _TagFriendsWidgetState extends ConsumerState<TagFriendsWidget>
    with AppNavigator {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    pop(context);
                  },
                  child: Icon(Icons.close_rounded)),
              Text(
                "Tag Friends",
                style: smallNormalTextBolder.copyWith(
                    color: GlobalColors.primaryColor),
              ),
              GestureDetector(
                  onTap: () {
                    pop(context);
                  },
                  child: Text("Done", style: smallNormalTextBolder)),
            ],
          ),
          10.verticalSpace,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // Rounded corners
            ),
            child: TextField(
              decoration: InputDecoration(
                hintStyle: normalTextPrimaryColor!
                    .copyWith(color: Color.fromRGBO(196, 196, 196, 1)),
                hintText: "Search friends",
                border: InputBorder.none, // Removes default underline
              ),
            ),
          ),
          10.verticalSpace,
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(0),
                    trailing: Checkbox(
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return states.contains(MaterialState.selected)
                            ? Colors.orange
                            : Colors.grey.shade400;
                      }),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      value: true,
                      onChanged: (bool? value) {
                        setState(() {
                          //isChecked = value!;
                        });
                      },
                    ),
                    title: Text(
                      "My Friend",
                      style: smallNormalTextBolder,
                      textAlign: TextAlign.start,
                    ),
                    leading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        width: 30,
                        height: 30,
                        child: ClipOval(
                          child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: "https://picsum.photos/id/237/200/300"),
                        )),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class LocationListWidget extends ConsumerStatefulWidget {
  const LocationListWidget({super.key});

  @override
  ConsumerState createState() => _LocationListWidgetState();
}

class _LocationListWidgetState extends ConsumerState<LocationListWidget>
    with AppNavigator {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    pop(context);
                  },
                  child: Icon(Icons.close_rounded)),
              Text(
                "Where are you?",
                style: smallNormalTextBolder.copyWith(
                    color: GlobalColors.primaryColor),
              ),
              Text("Done", style: smallNormalTextBolder),
            ],
          ),
          10.verticalSpace,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // Rounded corners
            ),
            child: TextField(
              decoration: InputDecoration(
                hintStyle: normalTextPrimaryColor!
                    .copyWith(color: Color.fromRGBO(196, 196, 196, 1)),
                hintText: "Search for a place...",
                border: InputBorder.none, // Removes default underline
              ),
            ),
          ),
          10.verticalSpace,
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      pop(context);
                    },
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      "Surulere, Lagos Nigeria",
                      style: smallNormalText,
                      textAlign: TextAlign.start,
                    ),
                    leading: Icon(Icons.location_on_outlined),
                  );
                }),
          )
        ],
      ),
    );
  }
}
