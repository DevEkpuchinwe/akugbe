import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/navigator.dart';

final homeProvider = ChangeNotifierProvider<HomeProvider>((ref) {
  return HomeProvider();
});

class HomeProvider extends ChangeNotifier with AppNavigator {

  XFile? newVideoToPost;

  Uint8List? newVideoThumbnail;

  XFile? newImageToPost;

  Uint8List? editedImageToPost;


  XFile? kycDocumentImage;

  File? kycDocumentFile;

  XFile? kycSelfie;

  bool idUploaded = false;

  bool selfieUploaded = false;

  uploadId(){
    idUploaded = true;
    notifyListeners();
  }

  uploadSelfie(){
  selfieUploaded = true;
  notifyListeners();
  }

  clearPreviousKYC(){
    kycDocumentImage = null;
    kycDocumentFile = null;
    kycSelfie = null;
  }

  clearPreviousPost(){
    newImageToPost = null;
    newVideoThumbnail = null;
    newVideoToPost = null;
    editedImageToPost = null;
    notifyListeners();
  }


}