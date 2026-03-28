import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pridesys_task/constants/endpoint.dart';

import '../model/character_response.dart';

class CharacterListProvider extends ChangeNotifier {
  final Box<CharacterResponse> apiBox = Hive.box<CharacterResponse>('apiBox');

  CharacterListProvider() {
    fetchCharacter();
  }

  String? errorMessage;
  bool isLoading = true;
  bool isFetchingMore = false;
  bool hasMore = true;
  List<Result> results = [];
  int _page = 1;
  DateTime? _lastFetchTime; // ✅ debounce এর জন্য

  Future<void> fetchCharacter() async {
    // Cache থেকে আগে দেখাও
    if (apiBox.containsKey('cache_character_data')) {
      results = apiBox.get('cache_character_data')?.results ?? [];
      isLoading = false;
      notifyListeners();
    }

    try {
      final response = await Dio().get("$baseUrl?page=$_page");
      final apiResponse = CharacterResponse.fromJson(response.data);
      final incomingResults = apiResponse.results ?? [];

      hasMore = apiResponse.info?.next != null;

      // Merge: local changes (favorite etc.) preserve করো
      final updatedList = incomingResults.map((newItem) {
        final index = results.indexWhere((e) => e.id == newItem.id);
        return index != -1 ? results[index] : newItem;
      }).toList();

      results = updatedList;

      // Hive এ save
      final toSave = apiResponse..results = updatedList;
      await apiBox.put('cache_character_data', toSave);

      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMore() async {
    // ✅ Guard 1: already loading বা শেষ page
    if (isFetchingMore || !hasMore) return;

    // ✅ Guard 2: debounce — 2 second এর আগে আবার call হবে না
    final now = DateTime.now();
    if (_lastFetchTime != null &&
        now.difference(_lastFetchTime!) < const Duration(seconds: 2)) {
      return;
    }
    _lastFetchTime = now;

    isFetchingMore = true;
    notifyListeners();

    try {
      _page++;
      final response = await Dio().get("$baseUrl?page=$_page");
      final apiResponse = CharacterResponse.fromJson(response.data);
      final newItems = apiResponse.results ?? [];

      hasMore = apiResponse.info?.next != null;

      // Duplicate এড়াতে id check
      final existingIds = results.map((e) => e.id).toSet();
      final uniqueNew = newItems
          .where((e) => !existingIds.contains(e.id))
          .toList();

      // ✅ APPEND করো, replace না
      results = [...results, ...uniqueNew];

      // ✅ Hive এ সব results একসাথে save
      final cached = apiBox.get('cache_character_data');
      if (cached != null) {
        cached.results = results;
        await apiBox.put('cache_character_data', cached);
      }

      errorMessage = null;
    } catch (e) {
      _page--; // fail হলে page rollback
      errorMessage = e.toString();
    } finally {
      isFetchingMore = false;
      notifyListeners();
    }
  }

  void updateCharacterLocally(Result updatedItem) async {
    final index = results.indexWhere((e) => e.id == updatedItem.id);
    if (index != -1) {
      results[index] = updatedItem;
      final currentData = apiBox.get('cache_character_data');
      if (currentData != null) {
        currentData.results = results;
        await apiBox.put('cache_character_data', currentData);
      }
      notifyListeners();
    }
  }
}


// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:pridesys_task/constants/endpoint.dart';

// import '../model/character_response.dart';

// class CharacterListProvider extends ChangeNotifier {
//   final Box<CharacterResponse> apiBox = Hive.box<CharacterResponse>('apiBox');

//   CharacterListProvider() {
//     fetchCharacter();
//   }

//   String? errorMessage;
//   bool isLoading = true;
//   List<Result> results = [];
//   int page = 1;

//   Future<void> fetchCharacter() async {
//     if (apiBox.containsKey('cache_character_data')) {
//       results = apiBox.get('cache_character_data')?.results ?? [];
//       isLoading = false;
//       notifyListeners();
//     }
//     try {
//       final response = await Dio().get("$baseUrl?page=$page");
//       CharacterResponse apiResponse = CharacterResponse.fromJson(response.data);
//       List<Result> incomingResults = apiResponse.results ?? [];
//       List<Result> updatedList = [];
//       for (var newItem in incomingResults) {
//         int index = results.indexWhere((element) => element.id == newItem.id);
//         if (index != -1) {
//           updatedList.add(results[index]);
//         } else {
//           updatedList.add(newItem);
//         }
//       }
//       apiResponse.results = updatedList;
//       await apiBox.put('cache_character_data', apiResponse);
//       results = updatedList;
//       errorMessage = null;
//     } catch (e) {
//       errorMessage = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   // When User update the data -> data will updated locally in Local Storage
//   void updateCharacterLocally(Result updatedItem) async {
//     int index = results.indexWhere((element) => element.id == updatedItem.id);
//     if (index != -1) {
//       results[index] = updatedItem;
//       var currentData = apiBox.get('cache_character_data');
//       if (currentData != null) {
//         currentData.results = results;
//         await apiBox.put('cache_character_data', currentData);
//       }
//       notifyListeners();
//     }
//   }
// }
