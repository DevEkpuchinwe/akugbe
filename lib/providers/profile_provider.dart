import 'package:akugbe/api_response_models/profie_response_model.dart';
import 'package:akugbe/api_services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/app_utils.dart';

final profileProvider = ChangeNotifierProvider<ProfileProvider>((ref) {
  return ProfileProvider();
});

class ProfileProvider extends ChangeNotifier with ProfileService {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  String? gender = "Male";

  void selectGender(value) {
    gender = value;
    notifyListeners();
  }

  ProfileResponseModel? profileResponseModel;

  void callGetUserProfile(BuildContext context) async {
    try {
      AppUtils.showLoadingDialog("Processing...", context);
      profileResponseModel = await getUserProfile();
      AppUtils.popLoadingDialog(context);
      if (profileResponseModel!.status == true) {
        fullNameController.text = profileResponseModel!.data!.fullname!;
        // addressController.text = profileResponseModel!.data!.
        phoneNumberController.text = profileResponseModel!.data!.phone ?? "";
        countryController.text = profileResponseModel!.data!.country ?? "";
        dateOfBirthController.text =
        "${profileResponseModel!.data!.dateOfBirth?.toLocal() ?? ""}".split(' ')[0];
        notifyListeners();
        print("object");
      } else {
        AppUtils.showErrorMessage(
            context,
            profileResponseModel?.message ?? "An error occurred",
            true,
            "Error", retryFunction: () {
          callGetUserProfile(context);
        });
      }
    } on Exception catch (error) {
      AppUtils.popLoadingDialog(context);
      AppUtils.showErrorMessage(context,
          error.toString().replaceFirst('Exception: ', ''), false, "Error");
    }
  }
}
