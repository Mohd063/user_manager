class TodoModel {
  final int userId;  
  final int id;       
  final String todo;
  final bool completed;

  TodoModel({
    required this.userId,
    required this.id,
    required this.todo,
    required this.completed,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      userId: json['userId'], 
      id: json['id'],       
      todo: json['todo'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,              
      'todo': todo,
      'completed': completed,
    };
  }
}
