import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:notion/models/card_list_model.dart';
import 'package:notion/models/structure_model.dart';
import '../card.dart';
import '../database.dart';

class CardListView extends StatefulWidget {
  const CardListView({Key? key}) : super(key: key);

  @override
  _CardListViewState createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
  int pageSyncInterval = 1; //seconds
  int structureSyncInterval = 5; //seconds

  List<String> pageIDs = [];
  List<String> pageTitles = [];
  List<String> pageCategories = [];
  List<String> categories = [];
  List<String> colors = [];

  void getPages() async {
    CardListModel cardListModel = await Database.getPages();
    List<String> pageIDs = [];
    List<String> pageTitles = [];
    List<String> pageCategories = [];

    for (var page in cardListModel.results!) {
      pageIDs.add(page.id!);
      pageTitles.add(page.properties!.name!.title![0].plainText!);
      if (page.properties!.status!.select == null) {
        pageCategories.add('No Status');
      } else {
        pageCategories.add(page.properties!.status!.select!.name!);
      }
    }

    setState(() {
      this.pageIDs = pageIDs;
      this.pageTitles = pageTitles;
      this.pageCategories = pageCategories;
    });
  }

  void getStructure() async {
    StructureModel structureModel = await Database.getStructure();
    List<Option> options = structureModel.properties!.status!.select!.options!;
    List<String> categories = [];
    List<String> colors = [];
    for (var option in options) {
      categories.add(option.name!);
      colors.add(option.color!);
    }
    ;
    setState(() {
      this.categories = categories;
      this.colors = colors;
    });
    PageCard.categories = categories;
    PageCard.colors = colors;
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: pageSyncInterval), (timer) {
      getPages();
    });
    Timer.periodic(Duration(seconds: structureSyncInterval), (timer) {
      getStructure();
    });
  }

  ListView buildCardList() {
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

  @override
  Widget build(BuildContext context) {
    return buildCardList();
  }
}
