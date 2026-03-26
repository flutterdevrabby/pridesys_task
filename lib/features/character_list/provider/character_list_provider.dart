import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pridesys_task/constants/endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/character_response.dart';

class CharacterListProvider extends ChangeNotifier {
  CharacterListProvider() {
    loadFromCache();
  }

  String? errorMessage;
  bool isLoading = true;
  List<Result> results = [];

  static const String _cacheKey = 'results';

  Future<void> fetchCharacter() async {

    // await clearCache();
    final Dio dio = Dio();
    try {
      final response = await dio.get(baseUrl);

      CharacterResponse characterResponse = CharacterResponse.fromJson(
        response.data,
      );

      if (characterResponse.results != null &&
          characterResponse.results!.isNotEmpty) {
       results = characterResponse.results ?? [];

        await writeData();
      } else {
        results = [];
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

 Future<void>  writeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> jsonList = results
        .map((result) => jsonEncode(result.toJson()))
        .toList();

    await prefs.setStringList(_cacheKey, jsonList);
  }

  Future<void> loadFromCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(_cacheKey);

    if (jsonList != null && jsonList.isNotEmpty) {
      results = jsonList
          .map((jsonStr) => Result.fromJson(jsonDecode(jsonStr)))
          .toList();
      isLoading = false;
      notifyListeners();
    }

    // Always fetch fresh data from API
    await fetchCharacter();
  }


  // CLEAR cache
  Future<void> clearCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }
}
