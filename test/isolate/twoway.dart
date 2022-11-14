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

  // r1.listen((message) {
  //   print('来自新线程的消息：${message.toString()}');
  // });

  SendPort p2 = r1.sendPort;
  // p2.send('来自主线程的消息');

  var msg = await sendToReceive(p2, 'hello');
  print("主线程接受到：$msg");
  print('multiThread end');
}

Future<void> newThread(SendPort p1) async {
  print('当前线程的名称：${Isolate.current.debugName}');

  ReceivePort r2 = ReceivePort();
  SendPort p2 = r2.sendPort;
  p1.send(p2);
  await for (var msg in r2) {
    var data = msg[0];
    print('新线程收到了来自主线程的消息：$data');
    SendPort replyPort = msg[1];
    replyPort.send(data);
  }
}

Future sendToReceive(SendPort port, msg) async {
  print('发送消息给新线程 ${msg.toString()}');
  ReceivePort reaponse = ReceivePort();
  port.send([msg, reaponse.sendPort]);
  return reaponse.first;
}
