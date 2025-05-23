import 'package:flutter/material.dart';

mixin AppNavigator {
  pushTo(BuildContext context, Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (builder) => route));
  }

  pop(BuildContext context) {
    Navigator.pop(context);
  }

  popToHome(BuildContext context) {
    Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
  }

  pushAndRemoveAllPreviousScreens(BuildContext context, Widget route){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => route),
            (Route<dynamic> route) => false);
  }

}
