import "package:flutter/material.dart";

import 'database.dart';

class Page extends StatelessWidget {
  String pageID;
  Page({Key? key, required this.pageID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Database.getPage(pageID);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        shadowColor: Colors.transparent,
      ),
      body: PageBody(),
      backgroundColor: Colors.blueGrey.shade900,
    );
  }
}

class PageBody extends StatefulWidget {
  const PageBody({Key? key}) : super(key: key);

  @override
  _PageBodyState createState() => _PageBodyState();
}

class _PageBodyState extends State<PageBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.blueGrey.shade200, width: 2),
                ),
              ),
              child: Text(
                "Page Title",
                style: TextStyle(color: Colors.white, fontSize: 36),
              )),
          SizedBox(height: 30),
          Container(
              child: Text(
            "Page Content",
            style: TextStyle(color: Colors.white, fontSize: 24),
          )),
        ],
      ),
    );
    ;
  }
}
