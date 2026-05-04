import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../config/colors.dart';
import '../custom_widgets/filled_stateless_button.dart';
import '../local_storage/secure_storage.dart';
import '../local_storage/user_preferences.dart';
import 'navigator.dart';


class AppUtils with AppNavigator{
  static final navigatorKey = GlobalKey<NavigatorState>();

//  static final NotificationUtils notificationUtils = NotificationUtils();

  static void logout() async {
    await SecureStorage().deleteAllValues();
    await UserPreferences.clearUserPreferences();
  }

  

  static String formatDate(DateTime date) {
    // Format as e.g., "Jun 4, 2025"
    return DateFormat('MMM d, y').format(date);
  }

  static showLoadingDialog(String message, BuildContext parentContext) {
    showDialog(
        barrierDismissible: false,
        context: parentContext,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: Center(
              child: IntrinsicHeight(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.5.w, vertical: 15.5.h),
                  decoration: BoxDecoration(
                      color: GlobalColors.unactiveColor,
                      shape: BoxShape.rectangle,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15)).w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: 4.0,
                        color: GlobalColors.primaryColor,
                      ),
                      10.verticalSpace,
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(message, style: normalText),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  static popLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }



  static void showSuccessMessage(BuildContext context, String text) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            // width: MediaQuery.of(context).size.width - 32.0,
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 24.0, bottom: 18.0),
            color: const Color(0xff25804d),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        text,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 13.0, height: 1.5),
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                              onTap: () => {Navigator.pop(bc)},
                              child: const Text(
                                "Close",
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  static showErrorMessage(
      BuildContext context, String text, bool showRetry, String? title,
      {Function? retryFunction}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: const Color(0xffd92731),
            padding: const EdgeInsets.only(
                top: 24.0, left: 16.0, right: 16.0, bottom: 18.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Image.asset("assets/bad.png"),
                // const SizedBox(
                //   width: 16.0,
                // ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title == null ? "Error" : title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        text,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 13.0, height: 1.5),
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                              onTap: () => {Navigator.pop(bc)},
                              child: const Text(
                                "DISMISS",
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(
                            width: 32.0,
                          ),
                          showRetry
                              ? GestureDetector(
                            onTap: (){
                              retryFunction?.call();
                            },
                                  child: const Text(
                                    "RETRY",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Container(),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  static Future<XFile?> singleVideoPicker(BuildContext context) async{
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    return video;

  }

  static Future<XFile?> singleImagePicker(BuildContext context) async{
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;

  }

  static Future<XFile?> captureImage(BuildContext context, {CameraDevice source = CameraDevice.rear}) async{
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera, preferredCameraDevice: source);
    return image;
  }

  static Future<Uint8List?> generateVideoThumbnail(String videoFilePath) async{
    final uint8list = await VideoThumbnail.thumbnailData(video: videoFilePath, quality: 25);
    return uint8list;
  }

  // static Future<XFile?> pickFile() async{
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   if (result != null) {
  //     XFile file = result.xFiles.first;
  //     return file;
  //   } else {
  //     return null;
  //   }
  //
  // }


 static Future<String?> convertXFileToBase64(XFile xfile) async {
    try {
      // Read the file as bytes
      final bytes = await xfile.readAsBytes();

      // Convert bytes to base64 string
      String base64String = base64Encode(bytes);
      return base64String;
    } catch (e) {
      print("Error converting XFile to Base64: $e");
      return null;
    }
  }



  static String colorToRgbString(Color color) {
    return 'rgb(${color.r},${color.g},${color.b})';
  }

  static String convertUrl(String url) {
    // Replace the domain and fix the backslash
    return url
        .replaceFirst('https://test.xpresspayments.com', 'https://pgsandbox.xpresspayments.com')
        .replaceAll('\\', '/');
  }

  static String formatAmount(String amount){
    return NumberFormat.currency(
        locale: "en_NG", symbol: "NGN ", decimalDigits: 2)
        .format(double.tryParse(amount) ?? 0);
  }

  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
