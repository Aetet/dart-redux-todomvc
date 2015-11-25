library js_interop_example;
import 'package:js/js.dart';

int findNextId(List<Todo> list) {
  return list.fold(0 ,(int currentId, dynamic elem) {
    return (elem.id > currentId) ? elem.id : currentId;
  });
}

List<Todo> addTodo(List<Todo> todos, String text) {
  int id = findNextId(todos) + 1;

  List<Todo> newTodos = [new Todo(
      id: id,
      text: text,
      completed: false
  )];

  todos.fold(newTodos, (List<Todo> todos, item) {
    Todo todo = new Todo(
        id: item.id,
        text: item.text,
        completed: item.completed
    );
    todos.add(todo);

    return todos;
  });

  return newTodos;
}

@JS()
@anonymous
external List<Todo> get todos;
external void set todos(List<Todo> todos);

@JS()
external void set dartState(List<Todo> todos);

@JS()
external void set dartAddTodo(Function addTodo);

@JS()
@anonymous
class Todo {
  external String get text;
  external bool get completed;
  external int get id;
  external factory Todo({String text, bool completed, int id});
}

void main() {

  List<Todo> todos = [
    new Todo(
        text: 'Add dart to react',
        completed: false,
        id: 10
    )
  ];
  dartState = todos;
  dartAddTodo = allowInterop(addTodo);

}
