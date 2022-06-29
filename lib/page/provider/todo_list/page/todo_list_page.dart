import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'todo_list_provider.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late ProviderTodoList _provider;

  @override
  void initState() {
    _provider = ProviderTodoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _provider,
        child: Builder(builder: (context) {
          var person = context.watch<ProviderTodoList>().list;
          return Scaffold(
            appBar: AppBar(
              title: const Text('todo list'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                children: [
                  TodoListSearchView(
                    onChanged: (String value) {
                      context.read<ProviderTodoList>().searchList(value);
                    },
                  ),
                  TodoListView(
                    persons: person,
                  ),
                ],
              ),
            ),
          );
        }));
  }
}

class TodoListSearchView extends StatelessWidget {
  const TodoListSearchView({Key? key, required this.onChanged})
      : super(key: key);
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
          width: 1,
          color: Colors.blue,
        )),
        alignment: Alignment.centerLeft,
        // height: 40,
        child: TextField(
          onChanged: (value) => onChanged.call(value),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ));
  }
}

class TodoListView extends StatelessWidget {
  const TodoListView({
    Key? key,
    required this.persons,
  }) : super(key: key);
  final List<Person> persons;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, index) {
        var p = persons[index];
        return ListTile(
          title: Text(p.name),
          subtitle: Text(p.note),
          leading: const FlutterLogo(),
        );
      },
      itemCount: persons.length,
    ));
  }
}
