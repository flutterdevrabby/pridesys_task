import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridesys_task/constants/text_font_style.dart';

class OriginInfo extends StatelessWidget {
  final String title;
  const OriginInfo({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(color: Color(0xFF141e3c)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          Text(
            title,
            style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
              color: Color(0xFF8ccde6),
              fontSize: 14.sp,
            ),
          ),

          Icon(Icons.arrow_right, color: Colors.white),
        ],
      ),
    );
  }
}
