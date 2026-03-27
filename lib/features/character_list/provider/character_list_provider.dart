import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pridesys_task/constants/endpoint.dart';

import '../model/character_response.dart';

class CharacterListProvider extends ChangeNotifier {
  CharacterListProvider() {
    fetchCharacter();
  }

  String? errorMessage;
  bool isLoading = true;
  List<Result> results = [];

  Future<void> fetchCharacter() async {
    final Dio dio = Dio();
    try {
      final response = await dio.get(baseUrl);

      CharacterResponse characterResponse = CharacterResponse.fromJson(
        response.data,
      );

      if (characterResponse.results != null &&
          characterResponse.results!.isNotEmpty) {
        results = characterResponse.results ?? [];
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
}
