import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';

class IsolatePage extends StatefulWidget {
  const IsolatePage({Key? key}) : super(key: key);

  @override
  State<IsolatePage> createState() => _IsolatePageState();
}

class _IsolatePageState extends State<IsolatePage> {
  @override
  void initState() {
    super.initState();
    multiThread();
  }

  static Future<void> multiThread() async {
    ReceivePort r1 = ReceivePort();
    SendPort p1 = r1.sendPort;

    /// 创建一个子线程。
    Isolate.spawn(newThread, p1);
    SendPort p2 = await r1.first;
    var msg = await sendToReceive(p2, 'hello');
    print('主线程接收到：$msg');
    // p2.send('来自主线程的消息');
  }

  static Future<void> newThread(SendPort p1) async {
    ReceivePort r2 = ReceivePort();
    SendPort p2 = r2.sendPort;
    p1.send(p2);
    await for (var msg in r2) {
      var data = msg[0];
      print('data:${data}');
      SendPort replayPort = msg[1];
      // 给主线程回复消息;
      replayPort.send(data);
    }
  }

  static Future sendToReceive(SendPort port, msg) async {
    print('sendToReceive: ${msg.toString()}');
    print('当前线程：名称 ${Isolate.current.debugName}');
    ReceivePort reaponse = ReceivePort();
    port.send([msg, reaponse.sendPort]);
    return reaponse.first;
  }

  @override
  void dispose() {
    super.dispose();
  }

  // static Future<void> multiThread() async {
  //   print('multiThread start');
  //   print("当前线程的名称：${Isolate.current.debugName}");
  //   ReceivePort r1 = ReceivePort();
  //   SendPort p1 = r1.sendPort;
  //   Isolate.spawn(newThread, p1);
  //   // var msg = r1.first;
  //   r1.listen((message) {
  //     print('来自新线程的消息：${message.toString()}');
  //     r1.close();
  //   });
  //   print('multiThread end');
  // }

  // static void newThread(SendPort p1) {
  //   print('当前线程的名称：${Isolate.current.debugName}');
  //   p1.send("abc");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('isolate'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              _testIsolate();
            },
            child: const Text('点击'),
          ),
        ],
      ),
    );
  }

  // 新的isolate中可以处理耗时任务
  static void doWork(SendPort port1) {
    ReceivePort rp2 = ReceivePort();
    SendPort port2 = rp2.sendPort;
    rp2.listen((message) {
      //9.10 rp2收到消息
      print("rp2 收到消息: $message");
    });
    // 将新isolate中创建的SendPort发送到main isolate中用于通信
    print("port1--new isolate发送消息");
    port1.send([0, port2]); //3.port1发送消息,传递[0,rp2的发送器]
    // 模拟耗时5秒
    sleep(const Duration(seconds: 5));
    print("port1--new isolate发送消息");
    port1.send([1, "这条信息是 port1 在new isolate中 发送的"]); //5.port1发送消息
    print("port2--new isolate发送消息");
    port2.send([1, "这条信息是 port2 在new isolate中 发送的"]); //6.port2发送消息
  }

  _testIsolate() async {
    ReceivePort rp1 = ReceivePort();
    SendPort port1 = rp1.sendPort;
    // 通过spawn新建一个isolate，并绑定静态方法
    Isolate newIsolate = await Isolate.spawn(doWork, port1);

    SendPort? port2;
    rp1.listen((message) {
      print("rp1 收到消息: $message"); //2.  4.  7.rp1收到消息
      if (message[0] == 0) {
        port2 = message[1]; //得到rp2的发送器port2
      } else {
        if (port2 != null) {
          print("port2 发送消息");
          port2!.send([1, "这条信息是 port2 在main isolate中 发送的"]); // 8.port2发送消息
        }
      }
    });
    print("port1--main isolate发送消息");
    port1.send([1, "这条信息是 port1 在main isolate中 发送的"]); //1.port1发送消息
    // newIsolate.kill();
  }
}
