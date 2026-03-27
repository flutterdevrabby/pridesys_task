import 'package:provider/provider.dart';

import '../features/character_list/provider/character_list_provider.dart';
import '../features/favorite/provider/favorite_provider.dart';

var registerProvider = [
  ChangeNotifierProvider<CharacterListProvider>(
    create: ((context) => CharacterListProvider()),
  ),
  ChangeNotifierProvider<FavoriteProvider>(
    create: ((context) => FavoriteProvider()),
  ),
];
