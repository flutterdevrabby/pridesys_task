import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridesys_task/common_widget/custom_text_field.dart';
import 'package:pridesys_task/constants/text_font_style.dart';

class UpdateOrigin extends StatelessWidget {
  final TextEditingController originController;
  const UpdateOrigin({super.key, required this.originController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(color: Color(0xFF141e3c)),
      child: Row(
        children: [
          //
          Expanded(
            flex: 1,
            child: CustomTextField(
              controller: originController,
              style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
                color: Color(0xFF8ccde6),
                fontSize: 14.sp,
              ),
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_right, color: Colors.white),
        ],
      ),
    );
  }
}
