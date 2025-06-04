import 'package:bloc/bloc.dart';
import 'package:manage_me/data/repositories/api/todo_api_repo.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoApiRepo todoLocalRepo;

  TodoBloc(this.todoLocalRepo) : super(TodoInitial()) {
    on<LoadTodos>((event, emit) async {
      emit(TodoLoading());
      try {
        final todos = await todoLocalRepo.fetchTodosByUser(event.userId);
        emit(TodoLoaded(todos));
      } catch (_) {
        emit(TodoError("Failed to load todos"));
      }
    });

   
  }
}
