import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:notion/change_notifier.dart';
import 'package:notion/models/card_list_model.dart';
import 'package:notion/models/structure_model.dart';
import 'package:provider/provider.dart';
import '../card.dart';
import '../database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CardListView extends StatefulWidget {
  const CardListView({Key? key}) : super(key: key);

  @override
  _CardListViewState createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
  int updateInterval = 1; //seconds

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

    Provider.of<UIChangeNotifier>(context, listen: false).setLoading(false);
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
    setState(() {
      this.categories = categories;
      this.colors = colors;
    });
    if (!categories.contains('No Status')) {
      categories.add('No Status');
      colors.add('grey');
    }
    PageCard.categories = categories;
    PageCard.colors = colors;
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: updateInterval), (timer) {
      getPages();
    });
    Timer.periodic(Duration(seconds: updateInterval), (timer) {
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
    while (Provider.of<UIChangeNotifier>(context).loading) {
      return const SpinKitPulse(
        color: Colors.white,
        size: 200,
      );
    }
    return buildCardList();
  }
}
