import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridesys_task/features/character_list/provider/character_list_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/text_font_style.dart';
import '../widget/character_widget.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Character"),
        centerTitle: false,
        titleTextStyle: TextFontStyle.headLine18CFFFFFFW700,
        backgroundColor: Colors.black,
      ),

      body: Consumer<CharacterListProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage != null) {
            log(provider.errorMessage.toString());
            return Center(child: Text(provider.errorMessage.toString()));
          } else {
            return GridView.builder(
              shrinkWrap: true,
              padding: .symmetric(horizontal: 16.w),
              itemCount: provider.results.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (_, index) {
                var data = provider.results[index];
                return CharacterWidget(data: data);
              },
            );
          }
        },
      ),
    );
  }
}
