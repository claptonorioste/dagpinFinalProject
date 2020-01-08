import 'package:flutter/material.dart';
import 'package:login/asses_view.dart';
import 'package:login/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssesPage extends StatefulWidget {
  final Function fn;
  AssesPage(this.fn);

  @override
  _AssesPageState createState() => _AssesPageState();
}

class _AssesPageState extends State<AssesPage> {
  int score = 0;

  bool isLoadComplete = false;
  List<QuestionModel> question = [];
  List<QuestionModel> selQuestion = [];
  String usertype = "";

  @override
  void initState() {
    super.initState();
    setupQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asses Thyself"),
      ),
      body: isLoadComplete == true
          ? ListView.builder(
              itemCount: selQuestion.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: ListTile(
                  title: Text(selQuestion[index].question.toString(),
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    showSimpleCustomDialog(
                        context, selQuestion[index].question,selQuestion[index].id.toString());
                  },
                ));
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  setscore(int setScore) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("score", setScore);
  }

  setupQuestions() async {
    selQuestion = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String user = pref.getString('usertype');
    var _fetchQuestion = await getQuestions();
    question = _fetchQuestion;
    for (int x = 0; x < question.length; x++) {
      if (question[x].qtype == user &&question[x].status == 0) {
        selQuestion.add(question[x]);
      }
    }
    print(user);
    setState(() {
      print(question);
      isLoadComplete = true;
    });
  }

  void getUsertype() async {}

  void showSimpleCustomDialog(BuildContext context, String question,String id) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                question,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      score++;
                      widget.fn(score);
                      print(score);
                      setscore(score);
                      Navigator.of(context).pop();
                      setStatusA(id);
                      setupQuestions();
                    },
                    child: Text(
                      'Im fine',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      score--;
                      print(score);
                      setscore(score);
                      Navigator.of(context).pop();
                      setStatusA(id);
                      setupQuestions();
                    },
                    child: Text(
                      'Cancel!',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }
}
