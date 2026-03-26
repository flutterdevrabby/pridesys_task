import 'package:provider/provider.dart';
import '../features/character_list/provider/character_list_provider.dart';

var registerProvider = [
  ChangeNotifierProvider<CharacterListProvider>(
    create: ((context) => CharacterListProvider()),
  ),
];
