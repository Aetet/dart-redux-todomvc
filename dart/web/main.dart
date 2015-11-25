library js_interop_example;
import 'package:js/js.dart';

int findNextId(List<Todo> list) {
  return list.fold(0 ,(int currentId, dynamic elem) {
    return (elem.id > currentId) ? elem.id : currentId;
  });
}

@JS('document.createElement')
external HtmlElement createDomElement(String el);

@JS()
class HtmlElement {
  external void set innerHtml(String html);
}

@JS('document.body.appendChild')
external appendChild(elem);

logToDom(String text) {
  dynamic div = createDomElement('div');
  div.innerHtml = text;
  appendChild(div);
}

@JS('JSON.stringify')
external String stringify(data, String par, int offset);

void modifyFirst(List<Todo> todos) {
  logToDom('====todos==== ${stringify(todos, null, 4)}');
  Todo com = todos.first;
  com.text = "OOOF!";
  logToDom('====todos after====== ${stringify(todos, null, 4)}');
}

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
