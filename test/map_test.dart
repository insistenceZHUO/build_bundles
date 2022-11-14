import 'package:flutter/cupertino.dart';

main (){
  final diameters = <num, String>{1.0: 'Earth'};
  final otherDiameters = <double, String>{0.383: 'Mercury', 0.949: 'Venus'};
  for (final item in otherDiameters.entries) {
    // print("item:$item");
    diameters.putIfAbsent(item.key, () => item.value);
  }
  debugPrint('diameters:$diameters');
}

class StudyExtend {
  StudyExtend();
}

class ChildClass extends StudyExtend {
  ChildClass();
}
