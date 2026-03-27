import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pridesys_task/common_widget/custom_network_image.dart';
import 'package:pridesys_task/constants/text_font_style.dart';

import '../../character_list/model/character_response.dart';
import '../widgets/character_info.dart';
import '../widgets/origin_info.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Result data;
  const CharacterDetailsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF19192d),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          data.name ?? "",
          style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            // Back character screen
            context.pop();
          },
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.favorite))],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .start,
          children: [
            // Image
            CustomCachedNetworkImage(
              imageUrl: data.image ?? "",
              width: double.infinity,
              height: 300.h,
            ),

            SizedBox(height: 10.h),

            // Name
            Center(
              child: Text(
                data.name ?? "",
                style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
                  fontSize: 20.sp,
                ),
              ),
            ),

            // Status
            Center(
              child: Text(
                data.status ?? "",
                style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
                  color: Colors.green,
                  fontSize: 12.sp,
                  fontWeight: .bold,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            // Info
            CharacterInfo(data: data),

            SizedBox(height: 20.h),
            // ORIGIN
            Text(
              "ORIGIN",
              style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),

            SizedBox(height: 6.h),
            OriginInfo(title: data.origin?.name ?? ""),

            SizedBox(height: 20.h),

            // LAST LOCATION UNKNOWN
            Text(
              "LAST KNOWN LOCATION",
              style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 6.h),
            OriginInfo(title: data.location?.name ?? ""),

            SizedBox(height: 20.h),

            // LAST LOCATION UNKNOWN
            Text(
              "Episod(${data.episode!.length.toString()})",
              style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 6.h),
            // OriginInfo(),
          ],
        ),
      ),
    );
  }
}
