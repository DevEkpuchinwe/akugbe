import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../config/text_styles.dart';

class AppTextForm extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? title;
  final String? prefix;
  final String? helperText;
  final Widget? prefixWidget;
  final Widget? prefixIcon;
  final TextInputType? textInputType;
  final int? maxlength;
  final Function(String)? onChanged;
  final Widget? sufficeIcon;
  final Widget? suffixWidget;
  final bool readOnly;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatter;
  final bool obscure;
  final Function()? onTap;

  const AppTextForm(
      {super.key,
        this.prefixIcon,
      this.controller,
      this.hintText,
      this.textInputType,
      this.title,
      this.maxlength,
      this.sufficeIcon,
      this.inputFormatter,
      this.validator,
      this.onChanged,
      this.obscure = false,
      this.prefix,
      this.helperText,
      this.readOnly = false,
      this.prefixWidget,
      this.suffixWidget,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) Text(title!, style: smallNormalTextBold),
        5.verticalSpace,
        TextFormField(
            onTap: onTap,
            readOnly: readOnly,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: obscure,
            controller: controller,
            keyboardType: textInputType,
            maxLength: maxlength,
            onChanged: onChanged,
            inputFormatters: inputFormatter,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
                suffix: suffixWidget,
                prefix: prefixWidget,
                helperText: helperText,
                prefixText: prefix,
                suffixIcon: sufficeIcon,
                hintText: hintText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(244, 244, 248, 1), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(244, 244, 248, 1), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromRGBO(244, 244, 248, 1)),
                  borderRadius: BorderRadius.circular(10),
                ),
                counterText: '',
                hintStyle: normalTextPrimaryColor!
                    .copyWith(color: Color.fromRGBO(196, 196, 196, 1)),
                labelStyle: boldText,
                filled: true,
                fillColor: Color.fromRGBO(244, 244, 248, 1)))
      ],
    );
  }
}

class PasswordTextForm extends StatefulWidget {
  PasswordTextForm({
    Key? key,
    this.onChanged,
    required this.controller,
    required this.text,
    required this.textInputType,
    required this.title,
    this.validator,
  }) : super(key: key);
  final Function()? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String text;
  final String title;
  final TextInputType textInputType;

  @override
  State<PasswordTextForm> createState() => _PasswordTextFormState();
}

class _PasswordTextFormState extends State<PasswordTextForm> {
  bool _passwordVisible = true;

  void _togglePasswordView() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: smallNormalTextBold),
        5.verticalSpace,
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          onChanged: (value) {
            widget.onChanged?.call();
          },
          obscureText: _passwordVisible,
          controller: widget.controller,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromRGBO(244, 244, 248, 1),
              suffixIcon: InkWell(
                onTap: _togglePasswordView,
                child: Icon(
                  _passwordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility,
                  color: GlobalColors.primaryColor,
                  size: 16,
                ),
              ),
              hintText: widget.text,
              hintStyle: normalTextPrimaryColor!
                  .copyWith(color: Color.fromRGBO(196, 196, 196, 1)),
              contentPadding: const EdgeInsets.only(
                  top: 15, bottom: 15, right: 20, left: 20),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromRGBO(244, 244, 248, 1), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromRGBO(244, 244, 248, 1), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color.fromRGBO(244, 244, 248, 1)),
                borderRadius: BorderRadius.circular(10),
              )),
        )
      ],
    );
  }
}

class MultiLineText extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  // final String title;
  final int? maxlength;
  final Function(String)? onChanged;
  final Widget? sufficeIcon;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatter;
  final bool obscure;
  final double height;

  const MultiLineText(
      {super.key,
      this.controller,
      required this.hintText,
      // required this.title,
      this.maxlength,
      this.sufficeIcon,
      this.inputFormatter,
      this.validator,
      this.onChanged,
      this.obscure = false,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     //   Text(title, style: smallNormalTextBold),
     //    5.verticalSpace,
        TextFormField(
            // buildCounter: (context,
            //     {required currentLength, required isFocused, maxLength}) {
            //   return Container(
            //     transform:
            //         Matrix4.translationValues(0, -kToolbarHeight * 0.5, 0),
            //     child: Text(
            //       "$currentLength/$maxLength",
            //       style: normalText,
            //     ),
            //   );
            // },
            textAlignVertical: TextAlignVertical.top,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: obscure,
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLength: maxlength,
            maxLines: null,
            expands: true,
            onChanged: onChanged,
            inputFormatters: inputFormatter,
            // maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: InputDecoration(
              suffixIcon: sufficeIcon,
              hintText: hintText,
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.circular(7.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 10.0),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.circular(7.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(7.5),
              ),
              hintStyle: normalTextPrimaryColor!
                  .copyWith(color: Color.fromRGBO(196, 196, 196, 1)),
              labelStyle: boldText,
              filled: true,
                fillColor: Colors.transparent
            ))
      ],
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final Function(dynamic) onChanged;
  final List<dynamic> items;
  final Widget hint;
  final double? width;
  final dynamic value;

  const CustomDropdown(
      {super.key,
      required this.onChanged,
      required this.items,
      required this.hint,
      this.width,
      this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: Color.fromRGBO(244, 244, 248, 1),
          borderRadius: BorderRadius.circular(7.5),
          border: Border.all(color: Color.fromRGBO(244, 244, 248, 1))),
      child: DropdownButton(
          value: value,
          menuWidth: width,
          isDense: false,
          icon: Icon(Icons.keyboard_arrow_down_sharp,
              color: Color.fromRGBO(196, 196, 196, 1)),
          hint: hint,
          elevation: 0,
          underline: Container(
            height: 0,
          ),
          borderRadius: BorderRadius.circular(7.5),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item, style: smallNormalText),
                  ))
              .toList(),
          onChanged: onChanged),
    );
  }
}
