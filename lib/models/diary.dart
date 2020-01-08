

// Import MaterialApp and other widgets which we can use to quickly create a material app
import 'package:flutter/material.dart';

// Code written in Dart starts exectuting from the main function. runApp is part of
// Flutter, and requires the component which will be our app's container. In Flutter,
// every component is known as a "widget".

// Every component in Flutter is a widget, even the whole app itself

class DiaryPage extends StatefulWidget {
  @override
  createState() => _DiaryPage();
}

class _DiaryPage extends State<DiaryPage> {
  List<String> _todoItems = [];
  TextEditingController _ctrler = TextEditingController();

  void _addTodoItem(String task) {
    // Only add the task if the user actually entered something
    if(task.length > 0) {
      // Putting our code inside "setState" tells the app that our state has changed, and
      // it will automatically re-render the list
      setState(() => _todoItems.add(task));
    }
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return   AlertDialog(
          title:   Text('Remove "${_todoItems[index]}"?'),
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
    return   ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText, int index) {
    return   Card(child: ListTile(
      title:   Text(todoText),
      onTap: () => _promptRemoveTodoItem(index)
    ),);
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
