import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'features/character_list/model/character_response.dart';
import 'providers/register_provider.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Registered all adapter here
  Hive.registerAdapter(CharacterResponseAdapter());
  Hive.registerAdapter(InfoAdapter());
  Hive.registerAdapter(ResultAdapter());
  Hive.registerAdapter(LocationAdapter());
  // Hive Box Name is here
  await Hive.openBox<CharacterResponse>('apiBox');

  // Favorite Box
   await Hive.openBox<Result>('favoriteBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiProvider(
          providers: registerProvider,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppRoutes.router,
          ),
        );
      },
    );
  }
}
