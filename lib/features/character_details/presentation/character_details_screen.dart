import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pridesys_task/common_widget/custom_network_image.dart';
import 'package:pridesys_task/constants/text_font_style.dart';
import 'package:pridesys_task/features/favorite/provider/favorite_provider.dart';
import 'package:pridesys_task/routes/routes.dart';
import 'package:pridesys_task/utils/toast.dart';
import 'package:provider/provider.dart';

import '../../character_list/model/character_response.dart';
import '../../character_list/provider/character_list_provider.dart';
import '../widgets/character_info.dart';
import '../widgets/origin_info.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Result data;
  const CharacterDetailsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterListProvider>(
      builder: (context, provider, child) {
        final latestData = provider.results.firstWhere(
          (element) => element.id == data.id,
          orElse: () => data,
        );
        return Scaffold(
          backgroundColor: Color(0xFF19192d),
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              latestData.name ?? "",
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

            actions: [
              Consumer<FavoriteProvider>(
                builder: (context, favoriteProvider, child) {
                  final bool isFav = favoriteProvider.isFavorite(latestData.id);
                  return IconButton(
                    onPressed: () {
                      favoriteProvider.toggleFavorite(latestData);

                      ToastUtil.showLongToast(
                        isFav
                            ? "Favorite removed successfully"
                            : "Favorite added successfully",
                      );
                    },
                    color: isFav ? Colors.red : Colors.black,
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border_outlined,
                    ),
                  );
                },
              ),

              SizedBox(width: 16.w),

              IconButton(
                onPressed: () {
                  context.push(
                    AppRoutes.updateCharacterScreen,
                    extra: latestData,
                  );
                },
                color: Colors.black,
                icon: Icon(Icons.edit),
              ),
            ],
          ),

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Image
                CustomCachedNetworkImage(
                  imageUrl: latestData.image ?? "",
                  width: double.infinity,
                  height: 300.h,
                ),

                SizedBox(height: 10.h),

                // Name
                Center(
                  child: Text(
                    latestData.name ?? "",
                    style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
                      fontSize: 20.sp,
                    ),
                  ),
                ),

                // Status
                Center(
                  child: Text(
                    latestData.status ?? "",
                    style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
                      color: Colors.green,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // Info
                CharacterInfo(data: latestData),

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
                OriginInfo(title: latestData.origin?.name ?? ""),

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
                OriginInfo(title: latestData.location?.name ?? ""),

                SizedBox(height: 20.h),

                // LAST LOCATION UNKNOWN
                Text(
                  "Episod(${latestData.episode!.length.toString()})",
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
      },
    );
  }
}
