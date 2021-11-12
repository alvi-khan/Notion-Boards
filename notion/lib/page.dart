import "package:flutter/material.dart";

import 'database.dart';
import 'models/page_model.dart';

class Page extends StatelessWidget {
  String pageID;
  String pageTitle;
  Page({Key? key, required this.pageID, required this.pageTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        shadowColor: Colors.transparent,
      ),
      body: PageBody(
        pageID: pageID,
        pageTitle: pageTitle,
      ),
      backgroundColor: Colors.blueGrey.shade900,
    );
  }
}

class PageBody extends StatefulWidget {
  String pageID;
  String pageTitle;
  PageBody({Key? key, required this.pageID, required this.pageTitle})
      : super(key: key);

  @override
  _PageBodyState createState() => _PageBodyState();
}

class _PageBodyState extends State<PageBody> {
  List<String> existingBlocks = [];
  String bodyContent = '';
  String titleContent = '';
  TextEditingController bodyController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  void getPageContent() async {
    PageModel pageModel = await Database.getPageContent(widget.pageID);
    String pageContent = '';
    for (var block in pageModel.results!) {
      existingBlocks.add(block.id!);
      if (block.paragraph!.text != []) {
        for (var text in block.paragraph!.text!) {
          pageContent += text.plainText!;
          pageContent += '\n';
        }
      }
    }
    if (mounted) {
      setState(() {
        bodyContent = pageContent;
        titleContent = widget.pageTitle;
        bodyController.text = bodyContent;
        titleController.text = titleContent;
      });
    }
  }

  void updatePageContent() {
    Database.updatePageContent(
        existingBlocks, widget.pageID, bodyController.text);
  }

  @override
  void initState() {
    super.initState();
    getPageContent();
  }

  @override
  void dispose() {
    super.dispose();
    updatePageContent();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, titleController.text);
        return false;
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.blueGrey.shade200, width: 2),
                ),
              ),
              child: TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.white, fontSize: 36),
                decoration: null,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: TextField(
                controller: bodyController,
                maxLines: null,
                style: const TextStyle(color: Colors.white, fontSize: 24),
                decoration: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
