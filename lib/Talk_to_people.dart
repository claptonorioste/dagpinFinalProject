import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController =  TextEditingController();

void _handleSubmitted(String text) {
  _textController.clear();
}
 Widget _buildTextComposer() {
  return  Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    child:  Row(
      children: <Widget>[
        
         Flexible(
          child:  TextField(
            controller: _textController,
            onSubmitted: _handleSubmitted,
            decoration:  InputDecoration.collapsed(
              hintText: "Send a message"),
          ),
        ),
         Container(                                                 
          margin:  EdgeInsets.symmetric(horizontal: 4.0),           
          child:  IconButton(                                       
            icon:  Icon(Icons.send),                                
            onPressed: () => _handleSubmitted(_textController.text)),  
        ),                                                             
      ],
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:  AppBar(title:  Text("Friendlychat")),
      body: _buildTextComposer(),
    );
  }
}