import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Placeholder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final headers = {"Accept:", "application/vnd.github+json"};
          final uri = Uri.https(
            "api.github.com/repos/amuelleratahs/flutter_install_update_web/releases",
          );

          try {} catch (e) {}
        },
        tooltip: 'Get Releases',
        child: const Icon(Icons.add),
      ),
    );
  }
}
