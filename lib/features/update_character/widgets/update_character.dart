import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridesys_task/common_widget/custom_text_field.dart';
import 'package:pridesys_task/constants/text_font_style.dart';

class UpdateCharacterInfo extends StatelessWidget {
  final TextEditingController specify;
  final TextEditingController gender;

  const UpdateCharacterInfo({
    super.key,
    required this.specify,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(color: Color(0xFF141e3c)),
      child: Column(
        spacing: 4.h,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //
          _buildWidget(title: 'Species', value: specify),
          _buildWidget(title: 'Gender', value: gender),
        ],
      ),
    );
  }
}

Widget _buildWidget({
  required String title,
  required TextEditingController value,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Title
      Expanded(
        flex: 3,
        child: Text(
          title,
          style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
            color: Colors.grey,
            fontSize: 12.sp,
          ),
        ),
      ),

      // Value
      Expanded(
        flex: 1,
        child: CustomTextField(
          controller: value,
          align: TextAlign.start,
          style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
      ),
    ],
  );
}
