import "package:flutter/material.dart" hide Page;
import 'package:notion/page.dart';
import 'database.dart';

class PageCard extends StatefulWidget {
  String id;
  String title;
  String category;
  static List<String> categories = [];
  static List<String> colors = [];

  PageCard(
      {Key? key, required this.id, required this.title, required this.category})
      : super(key: key);

  @override
  _PageCardState createState() => _PageCardState();
}

class _PageCardState extends State<PageCard> {
  void updatePage(String title, String category) {
    Database.updatePage(widget.id, title, category);
    setState(() {
      widget.category = category;
      widget.title = title;
    });
  }

  Color getColor(String category) {
    var index = PageCard.categories.indexOf(category);
    String color = PageCard.colors[index];
    switch (color) {
      case 'red':
        return Colors.redAccent.shade200;
      case 'green':
        return Colors.greenAccent;
      case 'yellow':
        return Colors.amber.shade200;
      default:
        return Colors.grey.shade300;
    }
  }

  void goToNextPage() async {
    String title = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Page(
          pageID: widget.id,
          pageTitle: widget.title,
        ),
      ),
    );
    if (title != "") updatePage(title, widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey.shade200, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        onTap: () => goToNextPage(),
        child: Ink(
          padding: EdgeInsets.all(20),
          color: Colors.blueGrey.shade700,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              DropdownButtonHideUnderline(
                  child: DropdownButton(
                borderRadius: BorderRadius.circular(10),
                items: PageCard.categories.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: getColor(value.toString()),
                      ),
                      child: Text(value),
                      padding: EdgeInsets.all(8),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  updatePage(widget.title, value.toString());
                },
                value: widget.category,
                style: TextStyle(fontSize: 16, color: Colors.black54),
                dropdownColor: Colors.blueGrey.shade600,
                icon: Container(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
