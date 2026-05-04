import 'package:akugbe/api_response_models/forgot_password_response.dart';
import 'package:akugbe/api_response_models/login_response.dart';
import 'package:akugbe/api_response_models/reset_password_response.dart';
import 'package:akugbe/api_response_models/resgister_response.dart';
import 'package:akugbe/screens/bottom_bar.dart';
import 'package:akugbe/screens/contact_details.dart';
import 'package:akugbe/screens/interests.dart';
import 'package:akugbe/screens/login.dart';
import 'package:akugbe/screens/personal_info.dart';
import 'package:akugbe/screens/profile_photo.dart';
import 'package:akugbe/screens/verification_sent.dart';
import 'package:akugbe/screens/verification_successful.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../api_services/auth_service.dart';
import '../local_storage/secure_storage.dart';
import '../screens/onboarding.dart';
import '../utils/app_utils.dart';
import '../utils/navigator.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider();
});

class AuthProvider extends ChangeNotifier with AuthService, AppNavigator {
  GlobalKey<FormState> loginKey = GlobalKey();
  GlobalKey<FormState> resetPasswordKey = GlobalKey();
  GlobalKey<FormState> createAccountKey = GlobalKey();
  GlobalKey<FormState> personalInfoKey = GlobalKey();
  GlobalKey<FormState> contactDetailsKey = GlobalKey();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String? gender;

  String? country;

  XFile? profilePic;

  RegisterResponse? registerResponse;
  ForgotPasswordResponse? forgotPasswordResponse;
  LoginResponse? loginResponse;
  ResetPasswordResponse? resetPasswordResponse;

  List<String> interests = [
    "Travel",
    "Fitness",
    "Technology",
    "Music",
    "Photography",
    "Cooking",
    "Fashion",
    "Gaming",
    "Movies",
    "Books",
    "Art",
    "Sports",
    "Health & Wellness",
    "Food",
    "Nature",
    "Entrepreneurship",
    "Finance",
    "Education",
    "Science",
    "Relationships",
    "DIY & Crafting",
    "Parenting",
    "Beauty & Skincare",
    "History",
    "Politics",
    "Culture",
    "Mental Health",
    "Podcasts",
    "Writing",
    "Dancing",
    "Pets & Animals",
    "Interior Design",
    "Spirituality",
    "Adventure",
    "Volunteering",
    "Self-Improvement",
    "Sustainability",
    "Comedy",
    "Astrology",
    "Automobiles",
    "Language Learning",
    "Theater",
    "Investment",
    "Social Justice",
    "Memes",
    "Crypto & Blockchain",
    "Startups",
    "Esports",
    "Astronomy",
  ];

  List<String> selectedInterests = [];

  DateTime? selectedDate;

  // Dispose controllers when no longer needed
  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    dateOfBirthController.dispose();
    countryController.dispose();
    phoneNumberController.dispose();
  }

  void logout(BuildContext context) {
    SecureStorage().deleteAllValues();
    pushAndRemoveAllPreviousScreens(context, Onboarding());
  }

  void resetPassword(BuildContext context) async {
    try {
      if (resetPasswordKey.currentState!.validate()) {
        AppUtils.showLoadingDialog("Processing...", context);
        Map<String, dynamic> requestParams = {
          "email": emailController.text,
          "otp": otpController.text,
          "password": passwordController.text,
          "password_confirmation": confirmPasswordController.text
        };
        resetPasswordResponse = await callResetPassword(requestParams);
        AppUtils.popLoadingDialog(context);
        if (resetPasswordResponse!.status == true) {
          pushTo(context, const Login());
        } else {
          AppUtils.showErrorMessage(
              context,
              resetPasswordResponse!.message ?? "An error occurred",
              false,
              "Error");
        }
      }
    } on Exception catch (error) {
      AppUtils.popLoadingDialog(context);
      AppUtils.showErrorMessage(context,
          error.toString().replaceFirst('Exception: ', ''), false, "Error");
    }
  }

  void callRegister(BuildContext context) async {
    try {
      if (createAccountKey.currentState!.validate()) {
        AppUtils.showLoadingDialog("Processing...", context);
        Map<String, dynamic> requestParams = {
          "step": 1,
          "data": {
            "username": userNameController.text,
            "email": emailController.text,
            "password": passwordController.text,
            "password_confirmation": confirmPasswordController.text
          }
        };
        registerResponse = await register(requestParams);
        AppUtils.popLoadingDialog(context);
        if (registerResponse!.status == true) {
          pushTo(context, const PersonalInfo());
        } else {
          AppUtils.showErrorMessage(context,
              registerResponse!.message ?? "An error occurred", false, "Error");
        }
      }
    } on Exception catch (error) {
      AppUtils.popLoadingDialog(context);
      AppUtils.showErrorMessage(context,
          error.toString().replaceFirst('Exception: ', ''), false, "Error");
    }
  }

  void callLogin(BuildContext context) async {
    if (loginKey.currentState!.validate()) {
      try {
        AppUtils.showLoadingDialog("Processing...", context);
        Map<String, dynamic> requestParams = {
          "email": emailController.text,
          "password": passwordController.text
        };
        loginResponse = await login(requestParams);

        if (loginResponse!.status == true) {
          await SecureStorage().writeValue("auth_token", loginResponse!.data!.token!);
          AppUtils.popLoadingDialog(context);
          pushAndRemoveAllPreviousScreens(context, const BottomBar());
        } else {
          AppUtils.popLoadingDialog(context);
          AppUtils.showErrorMessage(context,
              loginResponse?.message ?? "An error occurred", false, "Error");
        }
      } on Exception catch (error) {
        AppUtils.popLoadingDialog(context);
        AppUtils.showErrorMessage(context,
            error.toString().replaceFirst('Exception: ', ''), false, "Error");
      }
    }
  }

  void sendOtp(BuildContext context) async {
    try {
      if (resetPasswordKey.currentState!.validate()) {
        AppUtils.showLoadingDialog("Processing...", context);
        Map<String, dynamic> requestParams = {"email": emailController.text};
        forgotPasswordResponse = await forgotPassword(requestParams);
        AppUtils.popLoadingDialog(context);
        if (forgotPasswordResponse!.status == true) {
          pushTo(context, const VerificationSent());
        } else {
          AppUtils.showErrorMessage(
              context,
              forgotPasswordResponse!.message ?? "An error occurred",
              false,
              "Error");
        }
      }
    } on Exception catch (error) {
      AppUtils.popLoadingDialog(context);
      AppUtils.showErrorMessage(context,
          error.toString().replaceFirst('Exception: ', ''), false, "Error");
    }
  }

  void verifyOtp(BuildContext context, String code) {
    print(code);
    if (code.length == 4) {
      pushTo(context, const VerificationSuccessful());
    }
  }

  void savePersonalInfo(BuildContext context) async {
    try {
      if (personalInfoKey.currentState!.validate() && gender != null) {
        AppUtils.showLoadingDialog("Processing...", context);
        Map<String, dynamic> requestParams = {
          "step": 2,
          "data": {
            "fullname": fullNameController.text,
            "date_of_birth":
                "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
            "gender": gender!.toLowerCase()
          },
          "user_id": registerResponse!.data?.userId
        };
        registerResponse = await register(requestParams);
        AppUtils.popLoadingDialog(context);
        if (registerResponse!.status == true) {
          pushTo(context, const ContactDetails());
        } else {
          AppUtils.showErrorMessage(context,
              registerResponse!.message ?? "An error occurred", false, "Error");
        }
      }
    } on Exception catch (error) {
      AppUtils.popLoadingDialog(context);
      AppUtils.showErrorMessage(context,
          error.toString().replaceFirst('Exception: ', ''), false, "Error");
    }
  }

  void selectGender(value) {
    gender = value;
    notifyListeners();
  }

  void selectCountry(value) {
    country = value;
    notifyListeners();
  }

  void saveContactDetails(BuildContext context) async {
    if (contactDetailsKey.currentState!.validate() && country != null) {
      try {
        AppUtils.showLoadingDialog("Processing...", context);
        Map<String, dynamic> requestParams = {
          "step": 3,
          "data": {
            "country": country,
            "phone": phoneNumberController.text,
          },
          "user_id": registerResponse!.data?.userId
        };
        registerResponse = await register(requestParams);
        AppUtils.popLoadingDialog(context);
        if (registerResponse!.status == true) {
          pushTo(context, const ProfilePhoto());
        } else {
          AppUtils.showErrorMessage(context,
              registerResponse!.message ?? "An error occurred", false, "Error");
        }
      } on Exception catch (error) {
        AppUtils.popLoadingDialog(context);
        AppUtils.showErrorMessage(context,
            error.toString().replaceFirst('Exception: ', ''), false, "Error");
      }
    }
  }

  void selectProfilePic(BuildContext context, XFile result) {
    profilePic = result;
    notifyListeners();
  }

  void savePhoto(BuildContext context) async {
    if (profilePic != null) {
      try {
        AppUtils.showLoadingDialog("Processing...", context);
        var base64image = await AppUtils.convertXFileToBase64(profilePic!);
        Map<String, dynamic> requestParams = {
          "step": 4,
          "data": {
            "profile_image": base64image,
          },
          "user_id": registerResponse!.data?.userId
        };
        registerResponse = await register(requestParams);
        AppUtils.popLoadingDialog(context);
        if (registerResponse!.status == true) {
          pushTo(context, const Interests());
        } else {
          AppUtils.showErrorMessage(context,
              registerResponse?.message ?? "An error occurred", false, "Error");
        }
      } on Exception catch (error) {
        AppUtils.popLoadingDialog(context);
        AppUtils.showErrorMessage(context,
            error.toString().replaceFirst('Exception: ', ''), false, "Error");
      }
    }
  }

  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
    notifyListeners();
  }

  void saveInterests(BuildContext context) async {
    if (selectedInterests.isEmpty) {
      AppUtils.showErrorMessage(context, "Select an interest", false, "Error");
    } else {
      try {
        AppUtils.showLoadingDialog("Processing...", context);
        Map<String, dynamic> requestParams = {
          "step": 5,
          "data": {
            "interest": selectedInterests,
          },
          "user_id": registerResponse!.data?.userId
        };
        registerResponse = await register(requestParams);
        AppUtils.popLoadingDialog(context);
        if (registerResponse!.status == true) {
          AppUtils.showSuccessMessage(
              context, "Congratulations, profile complete");
        } else {
          AppUtils.showErrorMessage(context,
              registerResponse?.message ?? "An error occurred", false, "Error");
        }
      } on Exception catch (error) {
        AppUtils.popLoadingDialog(context);
        AppUtils.showErrorMessage(context,
            error.toString().replaceFirst('Exception: ', ''), false, "Error");
      }
    }
  }
}
