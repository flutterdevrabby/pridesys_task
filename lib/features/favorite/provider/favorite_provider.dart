import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pridesys_task/features/character_list/model/character_response.dart';

class FavoriteProvider extends ChangeNotifier {
  // initial the favorite Box
  final Box<Result> _favoriteBox = Hive.box<Result>('favoriteBox');
  // Get all Favorite data as a List
  List<Result> get favoriteCharacters => _favoriteBox.values.toList();

  // Check any character favorite or not
  bool isFavorite(int? id) {
    if (id == null) return false;
    return _favoriteBox.containsKey(id);
  }

  // Favorite add remove function

  Future<void> toggleFavorite(Result character) async {
    if (character.id == null) return;

    if (_favoriteBox.containsKey(character.id)) {
      await _favoriteBox.delete(character.id);
    } else {
      await _favoriteBox.put(character.id, character);
    }

    notifyListeners();
  }

  // Delete all favorite Item
  // Future<void> clearAllFavorites() async {
  //   await _favoriteBox.clear();
  //   notifyListeners();
  // }
}
