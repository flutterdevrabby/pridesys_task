import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridesys_task/common_widget/custom_network_image.dart';
import 'package:pridesys_task/constants/text_font_style.dart';

import '../widgets/character_info.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .start,
          children: [
            // Image
            CustomCachedNetworkImage(
              imageUrl: '',
              width: double.infinity,
              height: 300.h,
            ),

            // Name
            Text('', style: TextFontStyle.headLine18CFFFFFFW700),

            // Status
            Text('', style: TextFontStyle.headLine18CFFFFFFW700),

            // Info
            CharacterInfo(),

            // ORIGIN
            Text("ORIGIN", style: TextFontStyle.headLine18CFFFFFFW700),

            // LAST LOCATION UNKNOWN
            Text(
              "LAST LOCATION UNKNOWN",
              style: TextFontStyle.headLine18CFFFFFFW700,
            ),
          ],
        ),
      ),
    );
  }
}
