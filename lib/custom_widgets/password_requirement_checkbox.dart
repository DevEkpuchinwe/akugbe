import 'package:flutter/material.dart';

import '../config/text_styles.dart';

class PasswordRequirementsCheckbox extends StatelessWidget {
  final String text;
  final bool value;

  const PasswordRequirementsCheckbox(
      {super.key, required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: value
                  ? Container(
                alignment: Alignment.center,
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 15,
                ),
              )
                  : Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    const BorderRadius.all(Radius.circular(50)),
                    border: Border.all(color: Colors.grey)),
              ),
            ),
          ),
        ),
        Text(text, style: smallNormalText),
      ],
    );
  }
}