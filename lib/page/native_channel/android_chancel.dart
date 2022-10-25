import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidChancel extends StatefulWidget {
  const AndroidChancel({Key? key}) : super(key: key);

  @override
  State<AndroidChancel> createState() => _AndroidChancelState();
}

class _AndroidChancelState extends State<AndroidChancel> {

  late MethodChannel channel;
  @override
  void initState() {
    super.initState();
    channel = const MethodChannel('com.flutter.guide.MethodChannel');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('原生端与android之间端通信'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {

            },
            child: const Text("发送数据源"),
          )
        ],
      ),
    );
  }
}
