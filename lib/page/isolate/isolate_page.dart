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
