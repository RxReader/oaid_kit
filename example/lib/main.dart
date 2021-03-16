import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oaid_kit/oaid_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Oaid Kit'),
            ),
            body: ListView(
              children: <Widget>[
                ListTile(
                  title: const Text('getOaid'),
                  onTap: () async {
                    Supplier supplier = await Oaid.getOaid();
                    print(const JsonEncoder.withIndent('  ').convert(supplier));
                    await showCupertinoDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: const Text('getOaid'),
                          content: Text(const JsonEncoder.withIndent('  ').convert(supplier)),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
