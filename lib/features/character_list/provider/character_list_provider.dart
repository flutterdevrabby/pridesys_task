import 'dart:developer';

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
    // ১. প্রথমে লোকাল থেকে পুরো রেসপন্স চেক করুন
    if (apiBox.containsKey('cache_character_data')) {
      results = apiBox.get('cache_character_data')?.results ?? [];
      isLoading = false;
      notifyListeners();
    }

    try {
      final response = await Dio().get(baseUrl);
      CharacterResponse characterResponse = CharacterResponse.fromJson(
        response.data,
      );

      // ২. পুরো অবজেক্টটি 'last_response' কী-তে সেভ করুন
      await apiBox.put('cache_character_data', characterResponse);

      results = characterResponse.results ?? [];
    } catch (e) {
      log("Error or Offline: $e");
    } finally {
      isLoading = false;
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
