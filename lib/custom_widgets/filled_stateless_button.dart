import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/colors.dart';

class FilledStatelessButton extends StatelessWidget {
  const FilledStatelessButton(
      {super.key,
      required this.buttonColor,
      required this.textColor,
      required this.text,
      required this.onTap, this.outlineColor});

  final Color buttonColor;
  final Color textColor;
  final String text;
  final Color? outlineColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: 1.sw,
        decoration: BoxDecoration(
            color: buttonColor,
            border: Border.all(color: outlineColor == null ? GlobalColors.primaryColor : outlineColor!),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: GoogleFonts.inter(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.bold
          )
        ),
      ),
    );
  }
}
