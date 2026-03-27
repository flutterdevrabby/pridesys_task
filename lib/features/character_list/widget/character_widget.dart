import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridesys_task/constants/text_font_style.dart';

import '../../../common_widget/custom_network_image.dart';
import '../model/character_response.dart';

class CharacterWidget extends StatelessWidget {
  final Result data;
  const CharacterWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 3.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Image
        CustomCachedNetworkImage(
          imageUrl: data.image ?? "",
          width: 120.w,
          height: 80,
        ),

        // Name
        Text(
          data.name ?? "N/A",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextFontStyle.headLine18CFFFFFFW700.copyWith(fontSize: 12.sp),
        ),

        // Species
        Text(
          data.species ?? "N/A",
          maxLines: 2,
          overflow:TextOverflow .ellipsis,
          style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
            fontSize: 12.sp,
            color: Colors.blue,
          ),
        ),

        // Status
        Text(
          data.status ?? "N/A",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
            fontSize: 10.sp,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
