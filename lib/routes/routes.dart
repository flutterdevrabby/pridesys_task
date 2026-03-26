import 'package:go_router/go_router.dart';

import '../features/character_list/presentation/character_list_screen.dart';

class AppRoutes {
  AppRoutes._(); // private constructor

  // Route names
  static const String characterListScreen = '/characterListScreen';

  // GoRouter instance
  static final GoRouter router = GoRouter(
    initialLocation: characterListScreen,
    routes: [
      GoRoute(
        path: characterListScreen,
        builder: (context, state) => const CharacterListScreen(),
      ),

      //  GoRoute(
      //     path: homeScreen,
      //     builder: (context, state) {
      //       final data = state.extra as Map<String, dynamic>;

      //       return HomeScreen(data: data);
      //     },
      //   ),
    ],
  );
}
