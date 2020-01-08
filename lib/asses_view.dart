import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:login/models/users.dart';

var questions = List<QuestionModel>();

Future<List<QuestionModel>> getQuestions() async {
  final String url =
      'https://clydess.000webhostapp.com/view.php';
  try {
    http.Response response = await http.get(url);
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      try {
        Iterable list = json.decode(response.body);
        questions = list.map((model) => QuestionModel.fromjson(model)).toList();
        return questions;
      } catch (e) {
        print(e);
      }
      print("DONE");
    }
  } catch (e) {}
  return [];
}

Future setStatusA(String id) async {
  final String url =
      'https://clydess.000webhostapp.com/edit2.php';
  try {
    http.Response response = await http.post(url,body: {
      "id": id,
      "status": "1"
    });

    int statusCode = response.statusCode;
    if (statusCode == 200) {
      print("DONE");
    }
  } catch (e) {
    print(e);
  }
}