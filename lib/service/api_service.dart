import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_rest_api_demo/model/todo_task.dart';

class ApiService {

  final baseUrl = "http://192.168.1.8:3106";

  Client client = Client();

  Future<List<TodoTask>> getTodoList() async {
    final response = await client.get("$baseUrl/todo/getAll");
        if(response.statusCode == 200){
          final body = jsonDecode(response.body);
          return todoTaskFromJson(body);
        }
        return null;
  }
  Future<bool> createTodo(TodoTask todoTask) async {
    Map<String,String> header = {"content-type":"application/json"};

    final body = jsonEncode(todoTask.toJson());

    final response = await client.post("$baseUrl/todo/create",headers: header,body: body);

    print(response.body);

    return response.statusCode == 200;
  }

  Future<bool> updateTodo(TodoTask todoTask) async {
    Map<String,String> header = {"content-type":"application/json"};

    final body = jsonEncode(todoTask.toJson());

    final response = await client.put("$baseUrl/todo/update",headers: header,body: body);

    print(response.body);

    return response.statusCode == 200;
  }

  Future<bool> deleteTodo(int id) async {
    Map<String,String> header = {"content-type":"application/json"};


    final response = await client.delete("$baseUrl/todo/delete?id=$id",headers: header);

    print(response.body);

    return response.statusCode == 200;
  }

}