import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Release Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          const MyHomePage(title: 'Teste github release für Installer/Updater'),
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
      body: const Center(
        child: Text("Test"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final headers = {"Accept": "application/vnd.github+json"};
          final uri = Uri.https(
            "api.github.com",
            "/repos/amuelleratahs/flutter_install_update_web/releases",
          );

          try {
            final res = await http.get(uri, headers: headers);
            print(res.statusCode);
            print(res.body);
            if (res.statusCode == 200) {
              if (res.body.isNotEmpty) {
                final data = jsonDecode(res.body);
                print(data);
                for (var item in data) {
                  print(item["name"]);
                }
              }
            }
          } catch (e) {
            print(e);
          }
        },
        tooltip: 'Get Releases',
        child: const Icon(Icons.add),
      ),
    );
  }
}
