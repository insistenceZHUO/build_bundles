import 'package:flutter/material.dart';

class CountInheritedWidget extends InheritedWidget {
   CountInheritedWidget(
      {Key? key, required this.count, required Widget child,})
      : super(key: key, child: child);
  final int count;

  /// 获取组件树中最近的一个InheritedWidget;
  static CountInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CountInheritedWidget>();
  }

  /// 通知依赖该树共享数据的子widget;
  @override
  bool updateShouldNotify(CountInheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw oldWidget.count != count;
  }
}
