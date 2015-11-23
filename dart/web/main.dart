library js_interop_example;
import 'package:js/js.dart';
import 'dart:convert';


int findNextId(List<Todo> list) {
  return list.fold(0 ,(int currentId, dynamic elem) {
    return (elem['id'] > currentId) ? elem['id'] : currentId;
  });
}

State addTodo(String serializedState, String text) {
  Map state = JSON.decode(serializedState);
  List list = new List.from(state['todos']);

  int id = findNextId(list) + 1;

  List<Todo> newTodos = [new Todo(
      id: id,
      text: text,
      completed: false
  )];

  list.fold(newTodos, (List<Todo> todos, item) {
    Todo todo = new Todo(
        id: item['id'],
        text: item['text'],
        completed: item['completed']
    );
    todos.add(todo);

    return todos;
  });

  return new State(todos: newTodos);
}

@JS()
@anonymous
class State {
  external List<Todo> get todos;
  external factory State({List<Todo> todos});
}

@JS()
external void set dartState(State state);

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
  dartState = new State(todos: todos);
  dartAddTodo = allowInterop(addTodo);

}