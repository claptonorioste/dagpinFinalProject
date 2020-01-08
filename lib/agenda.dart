import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:login/agenda_view.dart';
import 'package:login/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgendaPage extends StatefulWidget {
  final Function fn;
  AgendaPage(this.fn);
  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  int score2 = 0;

  bool isLoadComplete = false;
  List<AgendaModel> agenda = [];
  List<AgendaModel> selAgenda = [];
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
        title: Text("Agenda Today"),
      ),
      body: isLoadComplete == true
          ? ListView.builder(
              itemCount: selAgenda.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: ListTile(
                  title: Text(selAgenda[index].question.toString(),
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    showSimpleCustomDialog(context, selAgenda[index].question,selAgenda[index].id.toString());
                  },
                ));
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  setscore(int setScore2) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("score2", setScore2);
  }

  setupQuestions() async {
    selAgenda = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String user = pref.getString('usertype');
    var _fetchQuestion = await getQuestions();
    agenda = _fetchQuestion;
    for (int x = 0; x < agenda.length; x++) {
      if (agenda[x].qtype == user && agenda[x].status == 0) {
        selAgenda.add(agenda[x]);
      }
    }
    print(user);
    setState(() {
      isLoadComplete = true;
    });
  }

  void getUsertype() async {}

  void showSimpleCustomDialog(BuildContext context, String question, String id,) {
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
                      score2++;
                      widget.fn(score2);
                      print(score2);
                      setscore(score2);
                      Navigator.of(context).pop();
                      setStatus(id);
                      setupQuestions();
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      score2--;
                      print(score2);
                      setscore(score2);
                      Navigator.of(context).pop();
                      setStatus(id);
                      setupQuestions();
                    },
                    child: Text(
                      'Canel!',
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
