import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridesys_task/constants/text_font_style.dart';

import '../../character_list/model/character_response.dart';

class CharacterInfo extends StatelessWidget {
  final Result data;

  const CharacterInfo({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: .symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(color: Color(0xFF141e3c)),
      child: Column(
        spacing: 4.h,
        mainAxisAlignment: .start,
        children: [
          //
          _buildWidget(title: 'Species', value: data.species ?? ""),
          _buildWidget(title: 'Gender', value: data.gender ?? ""),
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
      Text(
        title,
        style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
          color: Colors.grey,
          fontSize: 12.sp,
        ),
      ),

      // Value
      Text(
        value,
        style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
          color: Colors.white,
          fontSize: 12.sp,
        ),
      ),
    ],
  );
}
