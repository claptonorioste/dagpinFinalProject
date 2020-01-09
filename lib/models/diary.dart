

// Import MaterialApp and other widgets which we can use to quickly create a material app
import 'package:flutter/material.dart';
import 'package:login/models/todo.dart';
import 'package:login/sqflitedb.dart';

// Code written in Dart starts exectuting from the main function. runApp is part of
// Flutter, and requires the component which will be our app's container. In Flutter,
// every component is known as a "widget".

// Every component in Flutter is a widget, even the whole app itself

class DiaryPage extends StatefulWidget {
  @override
  createState() => _DiaryPage();
}

class _DiaryPage extends State<DiaryPage> {
  List<Diary> diaryRecord = [];
  TextEditingController _ctrler = TextEditingController();
  final db = DiaryDatabase();

  void _addTodoItem(String message) async {
    {
        db.addDiary(Diary(message: message));
         setupList();
    }
  }

  void _removeTodoItem(int index) async {
    print(index);
    db.removeDiary(index);
    setupList();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupList();
    
  }
  setupList() async {
 
    var fetchdata = await db.fetchAll();
    setState(() {
      diaryRecord = fetchdata;
    });
    print(diaryRecord);
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return   AlertDialog(
          title:   Text('Delete this ?'),
          actions: <Widget>[
              FlatButton(
              child:   Text('No'),
              // The alert is actually part of the navigation stack, so to close it, we
              // need to pop it.
              onPressed: () => Navigator.of(context).pop()
            ),
              FlatButton(
              child:   Text('Yes'),
              onPressed: () {
                _removeTodoItem(index);
                
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: diaryRecord.length,
      itemBuilder: (BuildContext context,int index){
        return Card(child: ListTile(
          onTap: (){
            _promptRemoveTodoItem(diaryRecord[index].id);
            
          },
          title: Text(diaryRecord[index].message),
        ),);
      },
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar:   AppBar(
        title:   Text('Diary')
      ),
      body: _buildTodoList(),
      floatingActionButton:   FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add Diary',
        child:   Icon(Icons.add)
      ),
    );
  }

  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
      // MaterialPageRoute will automatically animate the screen entry, as well as adding
      // a back button to close it
        MaterialPageRoute(
        builder: (context) {
          return   Scaffold(
            appBar:   AppBar(
              title:   Text('Add Diary')
            ),
            body:Column(children: <Widget>[
                 TextField(
              maxLines: 10,
              autofocus: true,
              controller: _ctrler,
              decoration:   InputDecoration(
                hintText: 'Record your day',
                contentPadding: const EdgeInsets.all(16.0)
              ),
            ),
            FlatButton(
              color: Colors.blue,
              child: Text("SUBMIT",style: TextStyle(color: Colors.white),),onPressed: (){
              _addTodoItem(_ctrler.text);
                _ctrler.clear();
                Navigator.pop(context);
            },)
            ],)
          );
        }
      )
    );
  }
}
