import 'package:flutter/material.dart';
import 'package:flutter_rest_api_demo/view/todo_form.dart';
import 'package:flutter_rest_api_demo/view/todo_list.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          key: _scaffoldState,
          title: Text("Todo List Management"),
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                print("On tap");
                Navigator.push(_scaffoldState.currentContext, MaterialPageRoute(
                  builder: (BuildContext context){
                    return TodoForm();
                  }
                ));
              },
              child: Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: TodoList(),
      ),
    );
  }
}
