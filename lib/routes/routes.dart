import 'package:go_router/go_router.dart';

import '../features/character_details/presentation/character_details_screen.dart';
import '../features/character_list/presentation/character_list_screen.dart';

class AppRoutes {
  AppRoutes._(); // private constructor

  // Route names
  static const String characterListScreen = '/characterListScreen';
  static const String characterDetailsScreen = '/characterDetailsScreen';

  // GoRouter instance
  static final GoRouter router = GoRouter(
    initialLocation: characterDetailsScreen,
    routes: [
      GoRoute(
        path: characterListScreen,
        builder: (context, state) => const CharacterListScreen(),
      ),
      GoRoute(
        path: characterDetailsScreen,
        builder: (context, state) => const CharacterDetailsScreen(),
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
