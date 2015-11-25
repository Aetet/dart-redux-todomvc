library js_interop_example;
import 'package:js/js.dart';

int findNextId(List<Todo> list) {
  return list.fold(0 ,(int currentId, dynamic elem) {
    return (elem.id > currentId) ? elem.id : currentId;
  });
}

void modifyFirst(List<Todo> todos) {
  print('todos: ${todos[0].text}');
  Todo com = todos.elementAt(0);
  com.text = "OOOF!";
  todos.insert(0, com);
  print('todos after: ${todos[0].text}');
  alertJS('Oh, we modify first element!');
}

@JS('alert')
external alertJS(String text);

@JS()
@anonymous
external List<Todo> get todos;
external void set todos(List<Todo> todos);
@JS()
@anonymous
class Todo {
  external String get text;
  external void set text(String text);
  external bool get completed;
  external int get id;
  external factory Todo({String text, bool completed, int id});
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
external void set dartState(List<Todo> todos);
@JS()
external void set dartAddTodo(Function addTodo);
@JS()
external void set dartModifyTodo(Function modifyFirst);

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
  dartModifyTodo = allowInterop(modifyFirst);
}
