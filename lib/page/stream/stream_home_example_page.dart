import 'dart:async';

import 'package:flutter/material.dart';

class StreamHomeExamplePage extends StatefulWidget {
  const StreamHomeExamplePage({Key? key}) : super(key: key);

  @override
  _StreamHomeExamplePageState createState() => _StreamHomeExamplePageState();
}

class _StreamHomeExamplePageState extends State<StreamHomeExamplePage> {
  int count = 0;
  final stream = Stream.periodic(const Duration(milliseconds: 100), (int i) {
    return 43;
  });

  final streamController = StreamController.broadcast();

  @override
  void initState() {
    super.initState();

    streamController.stream.listen((event) {
      print('event:$event');
    }, onDone: (){
      print('done:');
    }, onError: (err){
      print('error:$err');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('stream'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                streamController.sink.add(10);
              },
              child: const Text('10'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                streamController.sink.add(1);
                streamController.add(1);
              },
              child: const Text('1'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                streamController.sink.addError('opps');
              },
              child: const Text('Error'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                streamController.sink.close();
              },
              child: const Text('close'),
            ),
            const SizedBox(height: 20),
            StreamBuilder(
              stream: streamController.stream,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text('None: 没有数据流');
                  case ConnectionState.waiting:
                    return const Text('WAITING:等待数据流');
                  case ConnectionState.active:
                    if (snapshot.hasError) {
                      return Text('ACTIVE:错误,数据流${snapshot.error}');
                    }
                    return Text('ACTIVE:正常,${snapshot.data}');
                  case ConnectionState.done:
                    return const Text('没有数据流');
                }
                // return Container();
              },
            ),
            StreamBuilder(
              stream: streamController.stream,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text('None: 没有数据流');
                  case ConnectionState.waiting:
                    return const Text('WAITING:等待数据流');
                  case ConnectionState.active:
                    if (snapshot.hasError) {
                      return Text('ACTIVE:错误,数据流${snapshot.error}');
                    }
                    return Text('ACTIVE:正常,${snapshot.data}');
                  case ConnectionState.done:
                    return const Text('没有数据流');
                }
                // return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
