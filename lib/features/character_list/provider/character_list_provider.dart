import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pridesys_task/constants/endpoint.dart';
import 'package:pridesys_task/utils/toast.dart';

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
    // First load data from Local Storage cache
    if (apiBox.containsKey('cache_character_data')) {
      var cachedData = apiBox.get('cache_character_data');
      results = cachedData?.results ?? [];
      allResults = List.from(results);
      isLoading = false;
      // Clear any old errors if any
      errorMessage = null;
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
      if (results.isEmpty) {
        errorMessage = e.toString();
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // For Pagination
  Future<void> fetchMore() async {
    if (isFetchingMore || !hasMore || _isSearching) return;

    isFetchingMore = true;
    notifyListeners();

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
      ToastUtil.showLongToast('Internet not available!');
    } finally {
      isFetchingMore = false;
      notifyListeners();
    }
  }

  List<Result> _mergeWithFavorites(List<Result> incoming) {
    List<Result> merged = [];
    for (var newItem in incoming) {
      int index = allResults.indexWhere((e) => e.id == newItem.id);
      merged.add(index != -1 ? allResults[index] : newItem);
    }
    return merged;
  }

  // Update for Local Data storage
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

  // Searching Function
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

  // Search clear from list
  void clearSearch() {
    _isSearching = false;
    results = List.from(allResults);
    notifyListeners();
  }
}
