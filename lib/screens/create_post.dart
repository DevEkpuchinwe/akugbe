import 'dart:io';

import 'package:akugbe/config/colors.dart';
import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/network_config/network_base.dart';
import 'package:akugbe/providers/home_provider.dart';
import 'package:akugbe/screens/bottom_bar.dart';
import 'package:akugbe/screens/feed.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http_parser/http_parser.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


import '../custom_widgets/filled_stateless_button.dart';

class CreatePost extends ConsumerStatefulWidget {
  const CreatePost({super.key});

  @override
  ConsumerState createState() => _CreatePostState();
}

class _CreatePostState extends ConsumerState<CreatePost> with AppNavigator {
  final TextEditingController contentController = TextEditingController();
   @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  //final TextEditingController contentController = TextEditingController();

  Widget build(BuildContext context) {
  //  final TextEditingController contentController = TextEditingController();

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
                             controller: contentController, // attach the controller
                            style: normalText
                                .copyWith(color: GlobalColors.blackColor),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            // expands: true,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(0),
                              hintStyle: normalTextPrimaryColor.copyWith(
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
                              if (homeRef.editedImageToPost != null) //this video or picture is  the one to upload as the file when the post button is tapped 
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
                      "Port Harco, Nigeria",
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
                  onTap:  () {
                    print('post clicked');
                    postCreate(contentText:contentController.text);

                  // postCreate(contentText:'contentController.text');

                    //also send the details to db using the network config provider and 
                   // pushAndRemoveAllPreviousScreens(context, const Feed());
                  })
            ],
          ),
        ),
      )
      
      ),
      
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

  /*void postCrea() async {
  final homeRef = ref.read(homeProvider);

  FormData formData = FormData();

  // Add the text content
  formData.fields.add(MapEntry('content', 'Your post text here'));

  // Add image or video file if available
  if (homeRef.editedImageToPost != null) {
    formData.files.add(MapEntry(
      'image',
      MultipartFile.fromBytes(
        homeRef.editedImageToPost!,
        filename: 'image.jpg', // you can customize the name and extension
     //   contentType: MediaType('image', 'jpeg'), // import from 'package:http_parser/http_parser.dart'
     contentType: MediaType('application', 'octet-stream')

      ),
    ));
  } else if (homeRef.newVideoThumbnail != null) {
    // Assuming you also have the video bytes stored somewhere (homeRef.newVideoFile maybe)
    formData.files.add(MapEntry(
      'video',
      MultipartFile.fromBytes(
        homeRef.newVideoFile!, // <-- your actual video bytes
        filename: 'video.mp4',
        contentType: MediaType('video', 'mp4'),
      ),
    ));
  }

 
  try {
  final response = await NetworkConfig().postRequest(
    'posts',
    formData,
    needAuth: true,
    isFormData: true,
  );

  if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
    // Success - navigate or show success message
     print('Posts created successfully:');
     Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => BottomBar()),
);

   //pushAndRemoveAllPreviousScreens(context, const BottomBar());
  } else {
    // Handle non-success status codes
    print('Failed to create post: ${response.statusCode}');
  }
} on DioException catch (e) {
  // Handle network or request errors
  print('DioException: $e');
}

}*/


Future<String?> uploadMediaToSupabase(Uint8List fileBytes, String fileName, String contentType) async {
  final supabase = Supabase.instance.client;

  try {
    await supabase.storage
        .from('posts')
        .uploadBinary(
          fileName,
          fileBytes,
          fileOptions: FileOptions(
            upsert: true,
            contentType: contentType,
          ),
        );

    return supabase.storage.from('posts').getPublicUrl(fileName);
  } catch (e) {
    print('❌ Supabase Upload Error: $e');
    return null;
  }
}

void postCreate({required String contentText}) async {
  final homeRef = ref.read(homeProvider);

  // Step 1: Create post first
  FormData formData = FormData();
  formData.fields.add(MapEntry('content', contentText));

  try {
    final response = await NetworkConfig().postRequest(
      'posts',
      formData,
      needAuth: true,
      isFormData: true,
    );

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      final postId = response.data['data']['id'];
      print('✅ Post created: $postId');

      String? mediaUrl;

      // Step 2: Upload actual media to Supabase
      if (homeRef.editedImageToPost != null) {
        mediaUrl = await uploadMediaToSupabase(
          homeRef.editedImageToPost!,
          '$postId',
          'image/jpeg',
        );
      } else if (homeRef.newVideoFile != null) {
        mediaUrl = await uploadMediaToSupabase(
          homeRef.newVideoFile!,
          '$postId',
          'video/mp4',
        );
      }

      if (mediaUrl != null) {
        print('✅ Media uploaded to Supabase: $mediaUrl');

        // Optional: Update the post with media URL
        //await NetworkConfig().patchRequest(
       //   'posts/$postId',
        //  data: {'media_url': mediaUrl},
       //   needAuth: true,
       // );
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomBar()),
      );
    } else {
      print('❌ Failed to create post: ${response.statusCode}');
    }
  } on DioException catch (e) {
    print('❌ DioException: $e');
  }
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
                hintStyle: normalTextPrimaryColor
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
                      fillColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                        return states.contains(WidgetState.selected)
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
                hintStyle: normalTextPrimaryColor
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
