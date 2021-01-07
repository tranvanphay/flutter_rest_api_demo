import 'package:flutter/material.dart';
import 'package:flutter_rest_api_demo/model/todo_task.dart';
import 'package:flutter_rest_api_demo/service/api_service.dart';
import 'package:flutter_rest_api_demo/view/todo_form.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = new ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _apiService.getTodoList(), builder: (BuildContext context, AsyncSnapshot<List<TodoTask>> snapshot){
         if(snapshot.hasError){
           return Center(
             child: Text("Oops! Something wrong"),
           );
         }else if(snapshot.connectionState == ConnectionState.done){
           List<TodoTask> totoList = snapshot.data;

           return Padding(
               padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
               child: ListView.builder(
                 itemCount: totoList.length,
               itemBuilder: (context,index){
                TodoTask todoTask = totoList[index];
                return Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(todoTask.name,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                          Text(todoTask.priority),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FlatButton(
                                onPressed: (){
                                  print("deleting...");
                                  showDialog(context: context, builder: (context){
                                    return AlertDialog(
                                      title: Text("Warning"),
                                      content: Text("Are you sure to delete this todo?"),
                                      actions: [
                                        FlatButton(
                                          child: Text("Yes"),
                                          onPressed: (){
                                            print("Yes");
                                            Navigator.pop(context);
                                            _apiService.deleteTodo(todoTask.id).then((isSuccess){
                                              if(isSuccess){
                                                print("delete successfully");
                                              }else{
                                                print("delete failed");
                                              }
                                            });
                                          },
                                        ),

                                        FlatButton(
                                          child: Text("No"),
                                          onPressed: (){
                                            print("No");
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  });
                                },
                                child: Text("Delete",style: TextStyle(color: Colors.red),),
                              ),
                              FlatButton(
                                onPressed: (){
                                  print("Editing...");
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return TodoForm(todoTask:todoTask);
                                  }));
                                },
                                child: Text("Edit",style: TextStyle(color: Colors.blue),),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
           }),
           );
         }
         return Center(
           child: CircularProgressIndicator(),
         );
    },
    );
  }
}
