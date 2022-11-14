import 'dart:isolate';

import 'package:flutter/foundation.dart';

/// isolate单向通信。
main() => multiThread();

Future<void> multiThread() async {
  print('multiThread start');
  print("当前线程的名称：${Isolate.current.debugName}");
  ReceivePort r1 = ReceivePort();
  SendPort p1 = r1.sendPort;
  Isolate.spawn(newThread, p1);
  // var msg = r1.first;
  r1.listen((message) {
    print('来自新线程的消息：${message.toString()}');
  });
  print('multiThread end');
}

void newThread(SendPort p1) {
  print('当前线程的名称：${Isolate.current.debugName}');
  p1.send("abc");
}
