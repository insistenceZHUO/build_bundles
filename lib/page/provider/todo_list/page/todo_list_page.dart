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
          // var person = context.select((ProviderTodoList value) => value.list);
          var person = context.watch<ProviderTodoList>().list;
          return Scaffold(
            appBar: AppBar(
              title: const Text('todo list'),
              actions: [
                TextButton(onPressed: (){
                  context.read<ProviderTodoList>().addPerson();
                }, child: Text('新增一条数据'))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                children: [
                  TodoListSearchView(
                    onChanged: (String value) {
                      context.read<ProviderTodoList>().setSearchList(value);
                    },
                  ),
                  TodoListView(
                    persons: person,
                    onDelete: (index) {
                      context.read<ProviderTodoList>().deletePerson(index);
                    },
                    onEdit: (int index) {
                      context.read<ProviderTodoList>().editPerson(index);
                    }, onAdd: () {
                    context.read<ProviderTodoList>().addPerson();
                  },
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
    required this.onDelete,
    required this.onEdit,
    required this.onAdd,
  }) : super(key: key);
  final List<Person> persons;
  final Function(int index) onDelete;
  final Function(int index) onEdit;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, index) {
        var p = persons[index];
        return ListTile(
          title: Text(p.name),
          subtitle: Row(
            children: [
              Text(p.note),
              TextButton(
                onPressed: () {
                  onDelete.call(index);
                },
                child: const Text('删除'),
              ),
            ],
          ),
          leading: const FlutterLogo(),
          trailing: Column(
            children: [
              // TextButton(
              //   onPressed: () {
              //     onDelete.call(index);
              //   },
              //   child: const Text('删除'),
              // ),

              TextButton(
                onPressed: () {
                  onEdit.call(index);
                },
                child: const Text('修改'),
              ),

              // TextButton(
              //   onPressed: () {
              //     onAdd.call();
              //   },
              //   child: const Text('添加'),
              // ),
            ],
          ),
        );
      },
      itemCount: persons.length,
    ));
  }
}
