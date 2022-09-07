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
  List<String> releases = [];
  String? latestRelease;
  String currentRelease = "v0.0.2-alpha";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: releases.length,
        itemBuilder: (context, index) => ListTile(
          leading: latestRelease != null &&
                  latestRelease != currentRelease &&
                  latestRelease == releases[index]
              ? Icon(Icons.system_update_alt)
              : SizedBox(),
          title: Text(
            "${releases[index]}${releases[index] == currentRelease ? " - Installed" : ""}",
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
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
                    setState(() {
                      releases =
                          List.from((data as List).map((e) => e["name"]));
                    });
                    for (var item in releases) {
                      print(item);
                    }
                    setState(() {
                      latestRelease = releases.first;
                    });
                  }
                }
              } catch (e) {
                print(e);
              }
            },
            child: Text("Get releases"),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              final headers = {"Accept": "application/vnd.github+json"};
              final uri = Uri.https(
                "api.github.com",
                "/repos/amuelleratahs/flutter_install_update_web/releases/latest",
              );

              try {
                final res = await http.get(uri, headers: headers);
                print(res.statusCode);
                print(res.body);
                if (res.statusCode == 200) {
                  if (res.body.isNotEmpty) {
                    final data = jsonDecode(res.body);
                    print(data);
                    setState(() {
                      latestRelease = data["name"];
                    });
                  }
                }
              } catch (e) {
                print(e);
              }
            },
            child: Text("Get latest release"),
          ),
        ],
      ),
    );
  }
}
