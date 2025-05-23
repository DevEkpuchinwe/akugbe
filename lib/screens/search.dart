import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../config/text_styles.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> with AppNavigator {
  final List<String> _chipLabels = ["Top", "Places", "Post", "People"];
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Search",
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
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintStyle: normalTextPrimaryColor!
                      .copyWith(color: Color.fromRGBO(196, 196, 196, 1)),
                  hintText: "Search...",
                  border: InputBorder.none, // Removes default underline
                ),
              ),
            ),
            10.verticalSpace,
            Wrap(
              spacing: 8.0,
              children: List.generate(_chipLabels.length, (index) {
                return ChoiceChip(
                  shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  label: Text(_chipLabels[index]),
                  selected: _selectedIndex == index,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedIndex = selected ? index : -1;
                    });
                  },

                );
              }),
            )
          ],
        ),
      )),
    );
  }
}
