import 'dart:convert';

class TodoTask{
  int id;
  String name;
  String priority;
  String description;
  String duedate;

  TodoTask({this.id = 0,this.name,this.priority,this.description,this.duedate});

  factory TodoTask.fromJson(Map<String,dynamic> data){
    return TodoTask(
      id: data["id"],
      name: data["name"],
      priority: data["priority"],
      description: data["description"],
      duedate: data["duedate"],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      "id":id,
      "name":name,
      "priority":priority,
      "description":description,
      "duedate":duedate
    };
  }

  @override
  String toString() {
    return "Todo{id:$id, name: $name, priority: $priority, description: $description, duedate: $duedate}";
  }
}

List<TodoTask> todoTaskFromJson(List data){
  return List<TodoTask>.from(data.map((item) => TodoTask.fromJson(item)));
}

String todoTaskToJson(TodoTask data){
  final jsonData = data.toJson();
  return json.encode(data.toJson());
}