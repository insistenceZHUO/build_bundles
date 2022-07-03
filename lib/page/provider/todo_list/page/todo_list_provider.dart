import 'package:flutter/material.dart';

/// 在provider中，如果
class ProviderTodoList extends ChangeNotifier {
  ProviderTodoList() {
    _list = data.map((e) => Person.fromJson(e)).toList();
    notifyListeners();
  }

  List<Person> _searchList = [];

  List<Person> get searchList => _searchList;

  List<Person> _list = [];

  List<Person> get list {
    var a = _list.map((e) => e).toList();
    return a;
  }

  /// 搜索
  void setSearchList(String text) {
    _searchList = _list
        .where((element) =>
            element.name.toUpperCase().contains(text.toUpperCase()))
        .toList();
    notifyListeners();
  }

  /// 删除
  void deletePerson(int index) {
    _list.removeAt(index);
    notifyListeners();
  }

  /// 修改
  void editPerson(int index) {
    print('index:${index}');
    _list[index].name = '修改了这条数据';
    notifyListeners();
  }

  /// 添加
  void addPerson() {
    var person = Person.fromJson({
      "name": '新增一条数据',
    });
    _list.add(person);
    notifyListeners();
  }
}

class Person {
  late String name;
  late String note;

  Person({required this.name, required this.note});

  factory Person.fromJson(Map<String, String> json) =>
      Person(note: json['note'] ?? '', name: json['name'] ?? '');
}

List<Map<String, String>> data = [
  {"name": 'adsadsadsad', "note": '程序员'},
  {"name": 'ljkljljkl', "note": '程序员'},
  {"name": 'wqrqweqwewqe', "note": '程序员'}
];
