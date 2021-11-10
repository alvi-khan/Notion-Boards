import 'dart:convert';
import 'package:http/http.dart' as http;

class Database {
  static String databaseID = '08d756be93a74965bf3106db5566b108';
  static String token = 'secret_QgV1XWuUjXmZFLUJw4HoNZFOXfp5WxfgfZUkXepQW3b';

  static Future<List<List<String>>> getStructure() async {
    var url = Uri.parse('https://api.notion.com/v1/databases/$databaseID');
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Notion-Version': '2021-08-16',
      },
    );
    List<String> categories = [];
    List<String> colors = [];
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> options = data['properties']['Status']['select']['options'];
      for (var option in options) {
        categories.add(option['name']);
        colors.add(option['color']);
      }
      categories.add('No Status');
      colors.add('grey');
    }
    return [categories, colors];
  }

  static Future<List<List<String>>> getPages() async {
    var url =
        Uri.parse('https://api.notion.com/v1/databases/$databaseID/query');

    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Notion-Version': '2021-08-16',
      },
    );
    List<String> ids = [];
    List<String> titles = [];
    List<String> categories = [];
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> pages = data['results'];
      for (var page in pages) {
        ids.add(page['id']);
        titles.add(page['properties']['Name']['title'][0]['plain_text']);
        if (page['properties']['Status']['select'] != null) {
          categories.add(page['properties']['Status']['select']['name']);
        } else {
          categories.add("No Status");
        }
      }
    }
    return [ids, titles, categories];
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
