import 'package:flutter/material.dart';

class Chapter2Page extends StatefulWidget {
  const Chapter2Page({Key? key}) : super(key: key);

  @override
  _Chapter2PageState createState() {
    debugPrint('count createState');
    return _Chapter2PageState();
  }
}

class _Chapter2PageState extends State<Chapter2Page> {
  int count = 0;

  int _count = 0;

  void _incrementCounter() {
    setState(() {
      debugPrint('count setState');
      _count++;
    });
  }

  @override
  void initState() {
    debugPrint('count initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    debugPrint('count didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Chapter2Page oldWidget) {
    debugPrint('count didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    debugPrint('count deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void reassemble() {
    debugPrint('count reassemble');
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter生命周期函数'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_count',
              style: Theme.of(context).textTheme.headline4,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
                onPressed: _incrementCounter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
