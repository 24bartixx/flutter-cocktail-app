import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cocktail.dart';

const baseURL = "https://cocktails.solvro.pl/api/v1";

class ApiService {

  Future<List<Cocktail>> fetchCocktails() async {
    try {

      final httpResponse = await http.get(Uri.parse("$baseURL/cocktails"));

      debugPrint("HTTP response code: ${httpResponse.statusCode}");

      if(httpResponse.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(httpResponse.body)['data'];
        return jsonData.map((object) => Cocktail.fromJson(object as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load cocktails');
      }

    } catch(e) {
      throw Exception('Failed to fetch cocktails list: $e');
    }

  }

  Future<Cocktail> fetchCocktailById(Cocktail cocktail) async {

    try {
      final httpResponse = await http.get(Uri.parse('$baseURL/cocktails/${cocktail.id}'));

      debugPrint("HTTP response code: ${httpResponse.statusCode}");

      if(httpResponse.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(httpResponse.body)['data'];
        cocktail.addIngredients((jsonData['ingredients'] as List<dynamic>).map((object) => object as Map<String, dynamic>).toList());
        return cocktail;
      } else {
        throw Exception('Failed to load cocktails');
      }
    } catch(e) {
      throw Exception('Failed to fetch coctail by id: $e');
    }
    

    
  }

}


