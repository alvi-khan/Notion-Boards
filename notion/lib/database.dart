import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:notion/models/card_list_model.dart';
import 'package:notion/models/structure_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Database {
  static String databaseID = dotenv.env['DATABASE_ID']!;
  static String token = dotenv.env['TOKEN']!;

  static Future<StructureModel> getStructure() async {
    var url = Uri.parse('https://api.notion.com/v1/databases/$databaseID');
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Notion-Version': '2021-08-16',
      },
    );
    StructureModel structureModel = structureModelFromJson(response.body);
    return structureModel;
  }

  static Future<CardListModel> getPages() async {
    var url =
        Uri.parse('https://api.notion.com/v1/databases/$databaseID/query');
    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Notion-Version': '2021-08-16',
      },
    );
    CardListModel cardListModel = cardListModelFromJson(response.body);
    return cardListModel;
  }

  static void updatePage(String id, dynamic category) {
    var updateData = {
      "properties": {
        "Status": {
          if (category == "No Status")
            "select": null
          else
            "select": {"name": "$category"}
        }
      }
    };

    var url = Uri.parse('https://api.notion.com/v1/pages/$id');
    http.patch(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Notion-Version': '2021-08-16',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(updateData),
    );
  }
}
