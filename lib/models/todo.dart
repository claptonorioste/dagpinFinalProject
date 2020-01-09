import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

class Todo {
  String key;
  String subject;
  bool completed;
  String userId;

  Todo(this.subject, this.userId, this.completed);

  Todo.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    userId = snapshot.value["userId"],
    subject = snapshot.value["subject"],
    completed = snapshot.value["completed"];

  toJson() {
    return {
      "userId": userId,
      "subject": subject,
      "completed": completed,
    };
  }
}



Diary diaryFromJson(String str) {
  final jsonData = json.decode(str);
  return Diary.fromMap(jsonData);
}

String diaryToJson(Diary data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Diary {
  int id;
  String message;


  Diary({
    this.id,
    this.message
  });

  String toString() {
    return '{ ${this.id},${this.message}}';
  }
  

  factory Diary.fromMap(Map<String, dynamic> json) =>  Diary(
        id: json["id"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "message": message,
      };
}
