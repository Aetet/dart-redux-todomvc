library js_interop_example;
import 'package:js/js.dart';

@JS()
@anonymous
class State {
  external List<Todo> get todos;
  external factory State({List<Todo> todos});
}

@JS()
external void set dartState(State state);

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
}