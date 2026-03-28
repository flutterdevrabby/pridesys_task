import 'package:go_router/go_router.dart';

import '../features/character_details/presentation/character_details_screen.dart';
import '../features/character_list/model/character_response.dart';
import '../features/character_list/presentation/character_list_screen.dart';
import '../features/favorite/presentation/favorite_screen.dart';
import '../features/update_character/presentation/update_character_screen.dart';

class AppRoutes {
  AppRoutes._(); // private constructor

  // Route names
  static const String characterListScreen = '/characterListScreen';
  static const String characterDetailsScreen = '/characterDetailsScreen';
  static const String favoriteScreen = '/favoriteScreen';
  static const String updateCharacterScreen = '/updateCharacterScreen';

  // GoRouter instance
  static final GoRouter router = GoRouter(
    initialLocation: characterListScreen,
    routes: [
      GoRoute(
        path: characterListScreen,
        builder: (context, state) => const CharacterListScreen(),
      ),
      GoRoute(
        path: favoriteScreen,
        builder: (context, state) => const FavoriteScreen(),
      ),

      GoRoute(
        path: characterDetailsScreen,
        builder: (context, state) {
          final data = state.extra as Result;
          return CharacterDetailsScreen(data: data);
        },
      ),
      GoRoute(
        path: updateCharacterScreen,
        builder: (context, state) {
          final data = state.extra as Result;
          return UpdateCharacterScreen(data: data);
        },
      ),
    ],
  );
}
