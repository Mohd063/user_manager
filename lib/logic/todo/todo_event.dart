import 'package:manage_me/data/model/todo_model.dart';

abstract class TodoEvent {}

class LoadTodos extends TodoEvent {
  final int userId;

  LoadTodos({required this.userId});
}

class AddTodo extends TodoEvent {
  final TodoModel todo;
  AddTodo(this.todo);
}
