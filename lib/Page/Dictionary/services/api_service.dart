import 'dart:convert';

import 'package:flutter_study_jam/page/dictionary/model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  //
  static const String baseURL =
      'https://api.dictionaryapi.dev/api/v2/entries/en_US/';

  static Future<DictModel?> getword(query) async {
    final url = Uri.parse("$baseURL$query");
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        var json = jsonDecode(response.body);
        final DictModel dictModel = DictModel.fromJson(json[0]);
        return dictModel;
      } else {
        // Khoong co chu
        return null;
      }
    } catch (e) {
      //hhtp error
      return null;
    }
  }
}
