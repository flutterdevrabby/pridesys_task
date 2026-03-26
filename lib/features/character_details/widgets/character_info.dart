import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridesys_task/constants/text_font_style.dart';

class CharacterInfo extends StatelessWidget {
  const CharacterInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: .symmetric(horizontal: 16.w),
      decoration: BoxDecoration(color: Colors.black),
      child: Column(
        spacing: 10.h,
        mainAxisAlignment: .start,
        children: [
          //
          _buildWidget(title: 'Species', value: ''),
          _buildWidget(title: 'Gender', value: ''),
        ],
      ),
    );
  }
}

Widget _buildWidget({required String title, required String value}) {
  return Row(
    mainAxisAlignment: .spaceBetween,
    children: [
      // Title
      Text(title, style: TextFontStyle.headLine18CFFFFFFW700),

      // Value
      Text(value, style: TextFontStyle.headLine18CFFFFFFW700),
    ],
  );
}
