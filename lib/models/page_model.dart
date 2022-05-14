import 'dart:convert';

PageModel pageModelFromJson(String str) => PageModel.fromJson(json.decode(str));

String pageModelToJson(PageModel data) => json.encode(data.toJson());

class PageModel {
  PageModel({
    this.object,
    this.results,
    this.nextCursor,
    this.hasMore,
  });

  String? object;
  List<Result>? results;
  dynamic? nextCursor;
  bool? hasMore;

  factory PageModel.fromJson(Map<String, dynamic> json) => PageModel(
        object: json["object"] == null ? null : json["object"],
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        nextCursor: json["next_cursor"],
        hasMore: json["has_more"] == null ? null : json["has_more"],
      );

  Map<String, dynamic> toJson() => {
        "object": object == null ? null : object,
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "next_cursor": nextCursor,
        "has_more": hasMore == null ? null : hasMore,
      };
}

class Result {
  Result({
    this.object,
    this.id,
    this.createdTime,
    this.lastEditedTime,
    this.hasChildren,
    this.archived,
    this.type,
    this.paragraph,
  });

  String? object;
  String? id;
  DateTime? createdTime;
  DateTime? lastEditedTime;
  bool? hasChildren;
  bool? archived;
  String? type;
  Paragraph? paragraph;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        object: json["object"] == null ? null : json["object"],
        id: json["id"] == null ? null : json["id"],
        createdTime: json["created_time"] == null
            ? null
            : DateTime.parse(json["created_time"]),
        lastEditedTime: json["last_edited_time"] == null
            ? null
            : DateTime.parse(json["last_edited_time"]),
        hasChildren: json["has_children"] == null ? null : json["has_children"],
        archived: json["archived"] == null ? null : json["archived"],
        type: json["type"] == null ? null : json["type"],
        paragraph: json["paragraph"] == null
            ? null
            : Paragraph.fromJson(json["paragraph"]),
      );

  Map<String, dynamic> toJson() => {
        "object": object == null ? null : object,
        "id": id == null ? null : id,
        "created_time":
            createdTime == null ? null : createdTime!.toIso8601String(),
        "last_edited_time":
            lastEditedTime == null ? null : lastEditedTime!.toIso8601String(),
        "has_children": hasChildren == null ? null : hasChildren,
        "archived": archived == null ? null : archived,
        "type": type == null ? null : type,
        "paragraph": paragraph == null ? null : paragraph!.toJson(),
      };
}

class Paragraph {
  Paragraph({
    this.text,
  });

  List<TextElement>? text;

  factory Paragraph.fromJson(Map<String, dynamic> json) => Paragraph(
        text: json["text"] == null
            ? null
            : List<TextElement>.from(
                json["text"].map((x) => TextElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "text": text == null
            ? null
            : List<dynamic>.from(text!.map((x) => x.toJson())),
      };
}

class TextElement {
  TextElement({
    this.type,
    this.text,
    this.annotations,
    this.plainText,
    this.href,
  });

  String? type;
  TextText? text;
  Annotations? annotations;
  String? plainText;
  dynamic? href;

  factory TextElement.fromJson(Map<String, dynamic> json) => TextElement(
        type: json["type"] == null ? null : json["type"],
        text: json["text"] == null ? null : TextText.fromJson(json["text"]),
        annotations: json["annotations"] == null
            ? null
            : Annotations.fromJson(json["annotations"]),
        plainText: json["plain_text"] == null ? null : json["plain_text"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "text": text == null ? null : text!.toJson(),
        "annotations": annotations == null ? null : annotations!.toJson(),
        "plain_text": plainText == null ? null : plainText,
        "href": href,
      };
}

class Annotations {
  Annotations({
    this.bold,
    this.italic,
    this.strikethrough,
    this.underline,
    this.code,
    this.color,
  });

  bool? bold;
  bool? italic;
  bool? strikethrough;
  bool? underline;
  bool? code;
  String? color;

  factory Annotations.fromJson(Map<String, dynamic> json) => Annotations(
        bold: json["bold"] == null ? null : json["bold"],
        italic: json["italic"] == null ? null : json["italic"],
        strikethrough:
            json["strikethrough"] == null ? null : json["strikethrough"],
        underline: json["underline"] == null ? null : json["underline"],
        code: json["code"] == null ? null : json["code"],
        color: json["color"] == null ? null : json["color"],
      );

  Map<String, dynamic> toJson() => {
        "bold": bold == null ? null : bold,
        "italic": italic == null ? null : italic,
        "strikethrough": strikethrough == null ? null : strikethrough,
        "underline": underline == null ? null : underline,
        "code": code == null ? null : code,
        "color": color == null ? null : color,
      };
}

class TextText {
  TextText({
    this.content,
    this.link,
  });

  String? content;
  dynamic? link;

  factory TextText.fromJson(Map<String, dynamic> json) => TextText(
        content: json["content"] == null ? null : json["content"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "content": content == null ? null : content,
        "link": link,
      };
}
