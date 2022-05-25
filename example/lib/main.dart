import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oaid_kit/oaid_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Oaid Kit'),
            ),
            body: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('getOaid'),
                  onTap: () async {
                    final Supplier supplier = await Oaid.instance.getOaid();
                    if (kDebugMode) {
                      print(
                          const JsonEncoder.withIndent('  ').convert(supplier));
                    }
                    await showCupertinoDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text('getOaid'),
                          content: Text(
                            JsonEncoder.withIndent('  ').convert(supplier),
                            textAlign: TextAlign.start,
                          ),
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
