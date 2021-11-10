import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'database.dart';
import 'card.dart';

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
  List<String> pageIDs = [];
  List<String> pageTitles = [];
  List<String> pageCategories = [];
  List<String> categories = [];
  List<String> colors = [];

  void getData() async {
    List<List<String>> pages = await Database.getPages();
    List<List<String>> structure = await Database.getStructure();
    setState(() {
      pageIDs = pages.first;
      pageTitles = pages[1];
      pageCategories = pages.last;
      categories = structure.first;
      colors = structure.last;
    });
    PageCard.categories = categories;
    PageCard.colors = colors;
  }

  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      getData();
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:
          min(min(pageTitles.length, pageCategories.length), pageIDs.length),
      itemBuilder: (context, index) {
        return PageCard(
            id: pageIDs[index],
            title: pageTitles[index],
            category: pageCategories[index]);
      },
    );
  }
}
