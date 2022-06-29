import 'package:build_bundles/page/provider/provider_main_model.dart';
import 'package:build_bundles/page/provider/todo_list/page/todo_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderMainPage extends StatefulWidget {
  const ProviderMainPage({Key? key}) : super(key: key);

  @override
  _ProviderMainPageState createState() => _ProviderMainPageState();
}

class _ProviderMainPageState extends State<ProviderMainPage> {
  late ProviderMainModel _provider;

  @override
  void initState() {
    super.initState();
    _provider = ProviderMainModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: ProviderMainModel(),
        child: Builder(builder: (context) {
          var a = context.select((ProviderMainModel value) => value.count);
          return Scaffold(
            appBar: AppBar(
              title: const Text('provider'),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Selector<ProviderMainModel, int>(
                      builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Text(
                        '${value}',
                      ),
                    );
                  }, selector: (context, value) {
                    return value.count;
                  }),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<ProviderMainModel>().increment();
                      },
                      child: Text('点击加一'),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        child: Text('11222'),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextButton(onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                        return const TodoListPage();
                      }));
                    },
                    child: const Text('跳转到todo list页面')),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
