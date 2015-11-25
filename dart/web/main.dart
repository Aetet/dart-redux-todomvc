library js_interop_example;
import 'package:js/js.dart';

@JS()
@anonymous
external List<Todo> get todos;
external void set todos(List<Todo> todos);
@JS()
@anonymous
class Todo {
  external String get text;
  external bool get completed;
  external int get id;
  external factory Todo({String text, bool completed, int id});
}

@JS()
external void set dartState(List<Todo> todos);

void main() {
  List<Todo> todos = [
    new Todo(
        text: 'Add dart to react',
        completed: false,
        id: 10
    )
  ];
  dartState = todos;
}
