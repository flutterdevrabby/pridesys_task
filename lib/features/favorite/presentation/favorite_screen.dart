import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pridesys_task/features/favorite/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/text_font_style.dart';
import '../../../routes/routes.dart';
import '../../character_list/widget/character_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        //  context.read<CharacterListProvider>().fetchMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        title: Text(
          "My Favorite Characters",
          style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            // Back character screen
            context.pop();
          },
        ),
      ),

      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, child) {
          final favoriteList = favoriteProvider.favoriteCharacters;

          if (favoriteList.isEmpty) {
            return Center(
              child: Text(
                "No favorites added yet!",
                style: TextFontStyle.headLine18CFFFFFFW700,
              ),
            );
          } else {
            return GridView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: favoriteList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (_, index) {
                var data = favoriteList[index];
                return GestureDetector(
                  onTap: () {
                    context.push(AppRoutes.characterDetailsScreen, extra: data);
                  },
                  child: CharacterWidget(data: data),
                );
              },
            );
          }
        },
      ),
    );
  }
}
