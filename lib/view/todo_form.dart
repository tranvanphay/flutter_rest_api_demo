import 'package:flutter/material.dart';
import 'package:flutter_rest_api_demo/model/todo_task.dart';
import 'package:flutter_rest_api_demo/service/api_service.dart';

final _scaffoldState = GlobalKey<ScaffoldState>();

class TodoForm extends StatefulWidget {

  TodoTask todoTask;

  TodoForm({this.todoTask});

  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  ApiService _apiService = ApiService();

  bool _isLoading = false;

  bool _isFieldNameValid;
  bool _isFieldPriorityValid;
  bool _isFieldDescriptionValid;
  bool _isFieldDueDateValid;

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPriority = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerDueDate = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.todoTask!=null){
      _isFieldNameValid = true;
      _controllerName.text = widget.todoTask.name;

      _isFieldPriorityValid = true;
      _controllerPriority.text = widget.todoTask.priority;

      _isFieldDescriptionValid = true;
      _controllerDescription.text = widget.todoTask.description;

      _isFieldDueDateValid = true;
      _controllerDueDate.text = widget.todoTask.duedate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("Add todo"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controllerName,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Full name",
                errorText: _isFieldNameValid == null || _isFieldNameValid?null:"The field name is required",
              ),
              onChanged: (value){
                print("$value");
                bool isFieldValid = value.trim().isNotEmpty;
                if(isFieldValid != _isFieldNameValid){
                  setState(() {
                    _isFieldNameValid = isFieldValid;
                  });
                }
              },
            ),

            TextField(
              controller: _controllerPriority,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Priority",
                errorText: _isFieldPriorityValid == null || _isFieldPriorityValid?null:"The field Priority is required",
              ),
              onChanged: (value){
                print("$value");
                bool isFieldValid = value.trim().isNotEmpty;
                if(isFieldValid != _isFieldPriorityValid){
                  setState(() {
                    _isFieldPriorityValid = isFieldValid;
                  });
                }
              },
            ),

            TextField(
              controller: _controllerDescription,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Description",
                errorText: _isFieldDescriptionValid == null || _isFieldDescriptionValid?null:"The field description is required",
              ),
              onChanged: (value){
                print("$value");
                bool isFieldValid = value.trim().isNotEmpty;
                if(isFieldValid != _isFieldDescriptionValid){
                  setState(() {
                    _isFieldDescriptionValid = isFieldValid;
                  });
                }
              },
            ),TextField(
              controller: _controllerDueDate,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Due Date",
                errorText: _isFieldDueDateValid == null || _isFieldDueDateValid?null:"The field due date is required",
              ),
              onChanged: (value){
                print("$value");
                bool isFieldValid = value.trim().isNotEmpty;
                if(isFieldValid != _isFieldDueDateValid){
                  setState(() {
                    _isFieldDueDateValid = isFieldValid;
                  });
                }
              },
            ),

            Padding(
              padding: EdgeInsets.only(top: 8),
              child: RaisedButton(
                child: Text("Save",style: TextStyle(color: Colors.white),),
                color: Colors.blueAccent,
                onPressed: (){
                  if(_isLoading){
                    return;
                  }

                  setState(() {
                    _isLoading = true;
                  });

                  print("Save");
                  if(_isFieldNameValid== null || !_isFieldNameValid||
                      _isFieldPriorityValid== null || !_isFieldPriorityValid||
                      _isFieldDescriptionValid== null || !_isFieldDescriptionValid||
                      _isFieldDueDateValid== null || !_isFieldDueDateValid){
                    print("Is invalid");
                    /*_scaffoldState.currentContext.showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("The input data is invalid. Please check again"),
                      )
                    );*/
                    setState(() {
                      _isLoading = false;
                    });
                    return;
                  }

                  TodoTask todo = TodoTask(
                      name : _controllerName.text.toString(),
                      priority : _controllerPriority.text.toString(),
                      description : _controllerDescription.text.toString(),
                      duedate : _controllerDueDate.text.toString(),
                  );

                  print(todo.toString());

                  if(widget.todoTask!=null){
                    todo.id = widget.todoTask.id;
                    _apiService.updateTodo(todo).then((isSuccess){
                      setState(() {
                        _isLoading = false;
                      });

                      if(isSuccess){
                        Navigator.pop(_scaffoldState.currentContext);
                      }

                    }).catchError((onError) {
                      setState(() {
                        _isLoading = false;
                      });
                    });

                    setState(() {
                      _isLoading = false;
                    });
                  }else{
                    _apiService.createTodo(todo).then((isSuccess){
                      setState(() {
                        _isLoading = false;
                      });

                      if(isSuccess){
                        Navigator.pop(_scaffoldState.currentContext);
                      }

                    }).catchError((onError) {
                      setState(() {
                        _isLoading = false;
                      });
                    });

                    setState(() {
                      _isLoading = false;
                    });
                  }
                  return;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
