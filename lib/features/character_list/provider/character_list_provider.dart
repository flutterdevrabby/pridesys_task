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
  List<Result> results = [];
  

  Future<void> fetchCharacter() async {
    if (apiBox.containsKey('cache_character_data')) {
      results = apiBox.get('cache_character_data')?.results ?? [];
      isLoading = false;
      notifyListeners();
    }

    try {
      final response = await Dio().get(baseUrl);
      CharacterResponse apiResponse = CharacterResponse.fromJson(response.data);

      List<Result> incomingResults = apiResponse.results ?? [];

      List<Result> updatedList = [];

      for (var newItem in incomingResults) {
        int index = results.indexWhere((element) => element.id == newItem.id);

        if (index != -1) {
          updatedList.add(results[index]);
        } else {
          updatedList.add(newItem);
        }
      }

      apiResponse.results = updatedList;

      await apiBox.put('cache_character_data', apiResponse);

      results = updatedList;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }



  void updateCharacterLocally(Result updatedItem) async {
    int index = results.indexWhere((element) => element.id == updatedItem.id);
    if (index != -1) {
      results[index] = updatedItem;

      // হাইভ-এ পার্মানেন্টলি সেভ করা
      var currentData = apiBox.get('cache_character_data');
      if (currentData != null) {
        currentData.results = results;
        await apiBox.put('cache_character_data', currentData);
      }
      notifyListeners();
    }
  }

  // Future<void> fetchCharacter() async {
  //   final Dio dio = Dio();
  //   try {
  //     final response = await dio.get(baseUrl);

  //     CharacterResponse characterResponse = CharacterResponse.fromJson(
  //       response.data,
  //     );

  //     if (characterResponse.results != null &&
  //         characterResponse.results!.isNotEmpty) {
  //       results = characterResponse.results ?? [];
  //     } else {
  //       results = [];
  //     }
  //   } catch (e) {
  //     errorMessage = e.toString();
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }
}
