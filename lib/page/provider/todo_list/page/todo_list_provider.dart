import 'package:flutter/material.dart';

class ProviderTodoList extends ChangeNotifier {
  ProviderTodoList() {
    _list = data.map((e) => Person.fromJson(e)).toList();
    notifyListeners();
  }

  List<Person> _list = [];

  List<Person> get list => _list;

  /// 搜索
  void searchList(String text) {
    _list = _list.where((element) => element.name.toUpperCase().contains(text.toUpperCase())).toList();
     notifyListeners();
  }
}

class Person {
  final String name;
  final String note;

  Person({required this.name, required this.note});

  factory Person.fromJson(Map<String, String> json) =>
      Person(note: json['note'] ?? '', name: json['name'] ?? '');
}

List<Map<String, String>> data = [
  {"name": 'adsadsadsad', "note": '一个程序员'},
  {"name": 'ljkljljkl', "note": '一个程序员'},
  {"name": 'wqrqweqwewqe', "note": '一个程序员'}
];
