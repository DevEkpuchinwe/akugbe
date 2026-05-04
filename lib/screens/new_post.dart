import 'dart:io';

import 'package:akugbe/config/colors.dart';
import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/providers/home_provider.dart';
import 'package:akugbe/screens/new_image_edit.dart';
import 'package:akugbe/screens/new_post_video_editor.dart';
import 'package:akugbe/utils/app_utils.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_widgets/filled_stateless_button.dart';

class NewPost extends ConsumerStatefulWidget {
  const NewPost({super.key});

  @override
  ConsumerState createState() => _NewPostState();
}

class _NewPostState extends ConsumerState<NewPost> with AppNavigator {
  void _pickVideo() async {
    final video = await AppUtils.singleVideoPicker(context);
    if (video != null) {
      setState(() {
        ref.read(homeProvider).newImageToPost = null;
        ref.read(homeProvider).newVideoToPost = video;
      });
      _generateVideoThumbnail();
    }
  }

  void _pickImage() async {
    final image = await AppUtils.singleImagePicker(context);
    if (image != null) {
      setState(() {
        ref.read(homeProvider).newImageToPost = image;
        ref.read(homeProvider).newVideoToPost = null;
        ref.read(homeProvider).newVideoThumbnail = null;
      });
    }
  }

  void _generateVideoThumbnail() async {
    final thumbnail = await AppUtils.generateVideoThumbnail(
        ref.read(homeProvider).newVideoToPost!.path);
    if (thumbnail != null) {
      setState(() {
        ref.read(homeProvider).newVideoThumbnail = thumbnail;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeRef = ref.watch(homeProvider);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "New Post",
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
        child: Column(
          children: [
            if (homeRef.newVideoThumbnail != null)
              GestureDetector(
                onTap: () {
                  chooseImageOrVideo(() => _pickVideo(), () => _pickImage());
                },
                child: Container(
                    width: 1.sw,
                    height: 0.3.sh,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey)),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.memory(
                          homeRef.newVideoThumbnail!,
                          fit: BoxFit.cover,
                          width: 1.sw,
                        ),
                        Icon(Icons.play_circle_fill,
                            size: 64, color: Colors.white)
                      ],
                    )),
              ),
            if (homeRef.newImageToPost != null)
              GestureDetector(
                onTap: () {
                  chooseImageOrVideo(() => _pickVideo(), () => _pickImage());
                },
                child: Container(
                    width: 1.sw,
                    height: 0.3.sh,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey)),
                    clipBehavior: Clip.hardEdge,
                    child: Image.file(

                      File(homeRef.newImageToPost!.path),
                      fit: BoxFit.cover,
                      width: 1.sw,
                    )),
              ),
            if (homeRef.newVideoThumbnail == null && homeRef.newImageToPost == null)
              GestureDetector(
                onTap: () {
                  chooseImageOrVideo(() => _pickVideo(), () => _pickImage());
                },
                child: Container(
                  width: 1.sw,
                  height: 0.3.sh,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Image.asset("assets/folder.png")),
                      5.verticalSpace,
                      Text(
                        "Add Image or Video",
                        style: smallNormalText.copyWith(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            40.verticalSpace,
            FilledStatelessButton(
                buttonColor: GlobalColors.primaryColor,
                textColor: GlobalColors.blackColor,
                text: "Next",
                onTap: () {
                  if(homeRef.newImageToPost != null){
                      pushTo(context, const NewImageEdit());
                  }else if(homeRef.newVideoToPost != null){
                    pushTo(context, const VideoEditor());
                  }else{

                  }
                })
          ],
        ),
      )),
    );
  }

  void chooseImageOrVideo(Function video, Function image) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        showDragHandle: true,
        builder: (innerContext) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return FractionallySizedBox(
              heightFactor: 0.3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose Source",
                      style: boldText,
                    ),
                    20.verticalSpace,
                    TextButton(
                        onPressed: () {
                          pop(innerContext);
                          image.call();
                        },
                        child: Text(
                          "Image",
                          style: smallNormalText,
                        )),
                    TextButton(
                        onPressed: () {
                          pop(innerContext);
                          video.call();
                        },
                        child: Text(
                          "Video",
                          style: smallNormalText,
                        ))
                  ],
                ),
              ),
            );
          });
        });
  }
}
