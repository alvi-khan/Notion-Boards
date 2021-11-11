import 'package:flutter/material.dart';
import 'package:notion/views/card_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade900,
          centerTitle: true,
          title: Text(
            "Notion Boards",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: MyHomePage(),
        backgroundColor: Colors.blueGrey.shade900,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CardListView();
  }
}
