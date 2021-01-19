import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String res2 = "nothing here";
  Map<String, dynamic> fields;
  List<String> ids;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () async {
                  final res = await http.get(
                      'https://firestore.googleapis.com/v1/projects/desktop1-fe278/databases/(default)/documents/co5/gAEbg2Sxgg134sSLU9g5');

                  final r2 = json.decode(res.body);
                  final r3 = r2['fields'] as Map<String, dynamic>;
                  r3.forEach((key, value) {
                    value.forEach((key, value) {
                      value.forEach((key, value) {
                        for (var i = 0; i < value.length; i++) {
                          print(value[i]['stringValue']);
                        }
                      });
                    });
                  });
                  //print(r3);
                },
                child: Text('get data from firebase')),
            //Text(res3),
            TextButton(
                onPressed: () async {
                  final res = await http.post('http://127.0.0.1:5000/',
                      body: json.encode({
                        'fever': 80,
                        'age': 80,
                        'bodypain': 1,
                        'diffbreathing': 0,
                        'cough': 1
                      }));
                  final extractedres =
                      json.decode(res.body) as Map<String, dynamic>;

                  extractedres.forEach((key, value) {
                    print(value["corona"]);
                  });
                  // setState(() {
                  //   res2 = json.decode(res.body);
                  // });
                },
                child: Text('check cocid-19')),
            Text(res2),
            TextButton(
                onPressed: () async {
                  final response = await http.post(
                      'https://firestore.googleapis.com/v1/projects/desktop1-fe278/databases/(default)/documents/co5/',
                      body: json.encode({
                        "fields": {
                          "ff": {"stringValue": "99"},
                          "kk": {
                            "arrayValue": {
                              "values": [
                                {"stringValue": "sayed"}
                              ]
                            }
                          }
                        }
                      }));
                  String response2 = json.decode(response.body)['name'];
                  String response3 =
                      response2.substring(response2.lastIndexOf('/') + 1);

                  print(response3);
                },
                child: Text('post data')),

            TextButton(
                onPressed: () async {
                  final response = await http.patch(
                      'https://firestore.googleapis.com/v1/projects/desktop1-fe278/databases/(default)/documents/co5/DnnbHHojX2ZyKvkqVvyu',
                      body: json.encode({
                        "fields": {
                          "ff": {"stringValue": "120"}
                        }
                      }));
                  String response2 = json.decode(response.body)['name'];
                  String response3 =
                      response2.substring(response2.lastIndexOf('/') + 1);

                  print(response3);
                },
                child: Text('update data')),

            //delete
            TextButton(
                onPressed: () async {
                  final response = await http.delete(
                    'https://firestore.googleapis.com/v1/projects/desktop1-fe278/databases/(default)/documents/co5/DnnbHHojX2ZyKvkqVvyu',
                  );
                  String response2 = json.decode(response.body)['name'];
                  String response3 =
                      response2.substring(response2.lastIndexOf('/') + 1);

                  print(response3);
                },
                child: Text('delete data')),

            //get 2
            TextButton(
                onPressed: () async {
                  final res = await http.get(
                      'https://firestore.googleapis.com/v1/projects/desktop1-fe278/databases/(default)/documents/co5/');

                  //print(res.body);

                  Map<String, dynamic> res3;
                  res3 = json.decode(res.body) as Map<String, dynamic>;
                  // Map<String, dynamic> x2 = res3['documents'][0];
                  // x2.forEach((key, value) {
                  //   print(value);
                  // });
                  res3.forEach((key, value) {
                    for (var i = 0; i < value.length; i++) {
                      String name = value[i]['name'];
                      String id = name.substring(name.lastIndexOf('/') + 1);
                      print('${id}  ${i} ');
                      //ids[i] = id;
                    }
                  });
                },
                child: Text('get data from firebase2')),
          ],
        ),
      ),
    );
  }
}
