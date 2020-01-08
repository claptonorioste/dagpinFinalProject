class User {
  int userId;
  String _username;
  String _password;  User(this._username, this._password);  User.fromMap(dynamic obj) {
    this._username = obj['username'];
    this._password = obj['password'];
  }  String get username => _username;
  String get password => _password;  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;
    return map;
  }
}

class QuestionModel {
  int id;
  String qtype;
  String question;
  int status;
  
  
  QuestionModel(this.id, this.qtype ,this.question);  
  @override
  String toString() {
    return '{ ${this.id},${this.qtype},${this.question},${this.status} }';
  }
  
  QuestionModel.fromjson(Map<String , dynamic> map) 
  : id = int.parse(map['id']),
    qtype = map['qtype'],
    question = map['question'],
     status = int.parse(map['status']);



    Map<String , dynamic> tomapdb(){
      var map = Map<String , dynamic>();
      map['id'] = id;
      map['qtype'] = qtype;
      map['question'] = question;
      map['status'] = status;
      return map;
    }


}
class AgendaModel {
  int id;
  String qtype;
  String question;  
  int status;
  
   @override
  String toString() {
    return '{ ${this.id},${this.qtype},${this.question} }';
  }
  
  AgendaModel(this.id, this.qtype ,this.question,this.status);  
  
  AgendaModel.fromjson(Map<String , dynamic> map) 
  : id = int.parse(map['id']),
    qtype = map['qtype'],
    question = map['question'],
    status = int.parse(map['status']);


    Map<String , dynamic> tomapdb(){
      var map = Map<String , dynamic>();
      map['id'] = id;
      map['qtype'] = qtype;
      map['question'] = question;
      map['status'] = status;
      return map;
    }}


