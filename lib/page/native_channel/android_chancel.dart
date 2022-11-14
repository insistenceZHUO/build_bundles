import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidChancel extends StatefulWidget {
  const AndroidChancel({Key? key}) : super(key: key);

  @override
  State<AndroidChancel> createState() => _AndroidChancelState();
}

class _AndroidChancelState extends State<AndroidChancel> {
  late MethodChannel channel;

  var _data;

  @override
  void initState() {
    super.initState();
    channel = const MethodChannel('com.flutter.guide.MethodChannel');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('原生端与android之间端通信11'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                var result = await channel.invokeMethod<Map>(
                    "sendData", {'name': 'laoMeng', 'age': 18});
                var name = result!['name'] ?? '';
                var age = result['age'] ?? '';
                setState(() {
                  _data = '$name,$age';
                });
              },
              child: const Text("发送数据源"),
            ),
            Text('原生返回数据：$_data'),
            // ListView(
            //   // shrinkWrap: true,
            //   children: [],
            // ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: const [],
              ),
            ),
            const Text('12322'),
          ],
        ),
      ),
    );
  }
}
