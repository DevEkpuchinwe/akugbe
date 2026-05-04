import 'package:akugbe/screens/contact_details.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:akugbe/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../config/text_styles.dart';
import '../custom_widgets/filled_stateless_button.dart';
import '../custom_widgets/text_fields.dart';
import '../providers/authProvider.dart';

class PersonalInfo extends ConsumerStatefulWidget {
  const PersonalInfo({super.key});

  @override
  ConsumerState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends ConsumerState<PersonalInfo> with AppNavigator {
  @override

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1945),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        ref.read(authProvider).selectedDate = selectedDate;
        ref.read(authProvider).dateOfBirthController.text  = selectedDate != null
            ? "${selectedDate!.toLocal()}".split(' ')[0]
            : "No Date Selected";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: SingleChildScrollView(
            child: Form(
              key: auth.personalInfoKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){
                    pop(context);
                  }, icon: Icon(Icons.arrow_back_ios_new_rounded, color: GlobalColors.blackColor,)),
                  30.verticalSpace,
                  Text("Personal Information", style: header,),
                  10.verticalSpace,
                  Text("Tell us a bit about yourself", style: normalText,),
                  30.verticalSpace,
                  AppTextForm(
                    controller: auth.fullNameController,
                    validator: Validators.validateRequired,
                    title: "Full Name",
                    hintText: "Enter your full name",
                  ),
                  30.verticalSpace,
                  AppTextForm(
                    onTap: ()async{
                      await _selectDate(context);
                    },
                    readOnly: true,
                    controller: auth.dateOfBirthController,
                    validator: Validators.validateRequired,
                    title: "Date Of Birth",
                    hintText: "Enter date of birth",
                  ),
                  30.verticalSpace,
                  CustomDropdown(onChanged: (value) {
                    auth.selectGender(value);
                  },
                      value: auth.gender,
                      width: 1.sw,
                      items: ["Male", "Female"],
                      hint: Text("Gender", style: normalText,)),
                  40.verticalSpace,
                  FilledStatelessButton(
                      buttonColor: GlobalColors.primaryColor,
                      textColor: GlobalColors.blackColor,
                      text: "Next",
                      onTap: () {
                       auth.savePersonalInfo(context);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
