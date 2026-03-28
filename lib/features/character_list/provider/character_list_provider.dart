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
  List<Result> allResults = [];
  int page = 1;

  Future<void> fetchCharacter() async {
  
    if (apiBox.containsKey('cache_character_data')) {
      results = apiBox.get('cache_character_data')?.results ?? [];
      isLoading = false;
      notifyListeners();
    }

    try {
      final response = await Dio().get("$baseUrl?page=$page");
      CharacterResponse apiResponse = CharacterResponse.fromJson(response.data);

     
      hasMore = apiResponse.info?.next != null;

      List<Result> incomingResults = apiResponse.results ?? [];
      List<Result> updatedList = _mergeWithFavorites(incomingResults);

      apiResponse.results = updatedList;
      await apiBox.put('cache_character_data', apiResponse);

      results = updatedList;
      allResults = updatedList;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMore() async {
  
    if (isFetchingMore || !hasMore || _isSearching) return;

    isFetchingMore = true;
    notifyListeners();

    await Future.delayed(Duration(milliseconds: 300));

    try {
      page++;
      final response = await Dio().get("$baseUrl?page=$page");
      CharacterResponse apiResponse = CharacterResponse.fromJson(response.data);

      hasMore = apiResponse.info?.next != null;

      List<Result> incomingResults = apiResponse.results ?? [];
      List<Result> merged = _mergeWithFavorites(incomingResults);

      allResults.addAll(merged);
      results = List.from(allResults);

      
      var currentCache = apiBox.get('cache_character_data');
      if (currentCache != null) {
        currentCache.results = allResults;
        await apiBox.put('cache_character_data', currentCache);
      }

      errorMessage = null;
    } catch (e) {
      page--;
      errorMessage = e.toString();
    } finally {
      isFetchingMore = false;
      notifyListeners();
    }
  }

  // 
  List<Result> _mergeWithFavorites(List<Result> incoming) {
    List<Result> merged = [];
    for (var newItem in incoming) {
      int index = allResults.indexWhere((e) => e.id == newItem.id);
      merged.add(index != -1 ? allResults[index] : newItem);
    }
    return merged;
  }

  void updateCharacterLocally(Result updatedItem) async {
    int index = results.indexWhere((e) => e.id == updatedItem.id);
    if (index != -1) {
      results[index] = updatedItem;
      int allIndex = allResults.indexWhere((e) => e.id == updatedItem.id);
      if (allIndex != -1) allResults[allIndex] = updatedItem;

      var currentData = apiBox.get('cache_character_data');
      if (currentData != null) {
        currentData.results = allResults;
        await apiBox.put('cache_character_data', currentData);
      }
      notifyListeners();
    }
  }

  bool _isSearching = false;

  void searchCharacter(String searchTitle) {
    if (searchTitle.isEmpty) {
      _isSearching = false;
      results = List.from(allResults);
    } else {
      _isSearching = true;
      results = allResults
          .where(
            (item) =>
                item.name!.toLowerCase().contains(searchTitle.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _isSearching = false;
    results = List.from(allResults);
    notifyListeners();
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
//   List<Result> allResults = [];
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
//       allResults = updatedList;
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

//   void searchCharacter(String searchTitle) {
//     if (searchTitle.isEmpty) {
//       results = List.from(allResults);
//     } else {
//       results = allResults
//           .where(
//             (item) =>
//                 item.name!.toLowerCase().contains(searchTitle.toLowerCase()),
//           )
//           .toList();
//     }

//     notifyListeners();
//   }

//   // Clear search
//   void clearSearch() {
//     results = List.from(allResults);
//     notifyListeners();
//   }
// }
