import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:login/models/users.dart';

var agenda = List<AgendaModel>();

Future<List<AgendaModel>> getQuestions() async {
  final String url =
      'https://clydess.000webhostapp.com/agenda_view.php';
  try {
    http.Response response = await http.get(url);
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      try {
        Iterable list = json.decode(response.body);
        agenda = list.map((model) => AgendaModel.fromjson(model)).toList();
        return agenda;
      } catch (e) {
        print(e);
      }
      print("DONE");
    }
  } catch (e) {}
  return [];
}
Future setStatus(String id) async {
  final String url =
      'https://clydess.000webhostapp.com/edit1.php';
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

