import 'dart:convert';

CardListModel cardListModelFromJson(String str) =>
    CardListModel.fromJson(json.decode(str));

String cardListModelToJson(CardListModel data) => json.encode(data.toJson());

class CardListModel {
  CardListModel({
    this.object,
    this.results,
    this.nextCursor,
    this.hasMore,
  });

  String? object;
  List<Result>? results;
  dynamic? nextCursor;
  bool? hasMore;

  factory CardListModel.fromJson(Map<String, dynamic> json) => CardListModel(
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
    this.cover,
    this.icon,
    this.parent,
    this.archived,
    this.properties,
    this.url,
  });

  String? object;
  String? id;
  DateTime? createdTime;
  DateTime? lastEditedTime;
  dynamic? cover;
  dynamic? icon;
  Parent? parent;
  bool? archived;
  Properties? properties;
  String? url;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        object: json["object"] == null ? null : json["object"],
        id: json["id"] == null ? null : json["id"],
        createdTime: json["created_time"] == null
            ? null
            : DateTime.parse(json["created_time"]),
        lastEditedTime: json["last_edited_time"] == null
            ? null
            : DateTime.parse(json["last_edited_time"]),
        cover: json["cover"],
        icon: json["icon"],
        parent: json["parent"] == null ? null : Parent.fromJson(json["parent"]),
        archived: json["archived"] == null ? null : json["archived"],
        properties: json["properties"] == null
            ? null
            : Properties.fromJson(json["properties"]),
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "object": object == null ? null : object,
        "id": id == null ? null : id,
        "created_time":
            createdTime == null ? null : createdTime!.toIso8601String(),
        "last_edited_time":
            lastEditedTime == null ? null : lastEditedTime!.toIso8601String(),
        "cover": cover,
        "icon": icon,
        "parent": parent == null ? null : parent!.toJson(),
        "archived": archived == null ? null : archived,
        "properties": properties == null ? null : properties!.toJson(),
        "url": url == null ? null : url,
      };
}

class Parent {
  Parent({
    this.type,
    this.databaseId,
  });

  String? type;
  String? databaseId;

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        type: json["type"] == null ? null : json["type"],
        databaseId: json["database_id"] == null ? null : json["database_id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "database_id": databaseId == null ? null : databaseId,
      };
}

class Properties {
  Properties({
    this.status,
    this.assign,
    this.name,
  });

  Status? status;
  Assign? assign;
  Name? name;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        status: json["Status"] == null ? null : Status.fromJson(json["Status"]),
        assign: json["Assign"] == null ? null : Assign.fromJson(json["Assign"]),
        name: json["Name"] == null ? null : Name.fromJson(json["Name"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status == null ? null : status!.toJson(),
        "Assign": assign == null ? null : assign!.toJson(),
        "Name": name == null ? null : name!.toJson(),
      };
}

class Assign {
  Assign({
    this.id,
    this.type,
    this.people,
  });

  String? id;
  String? type;
  List<dynamic>? people;

  factory Assign.fromJson(Map<String, dynamic> json) => Assign(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        people: json["people"] == null
            ? null
            : List<dynamic>.from(json["people"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "people":
            people == null ? null : List<dynamic>.from(people!.map((x) => x)),
      };
}

class Name {
  Name({
    this.id,
    this.type,
    this.title,
  });

  String? id;
  String? type;
  List<Title>? title;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        title: json["title"] == null
            ? null
            : List<Title>.from(json["title"].map((x) => Title.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "title": title == null
            ? null
            : List<dynamic>.from(title!.map((x) => x.toJson())),
      };
}

class Title {
  Title({
    this.type,
    this.text,
    this.annotations,
    this.plainText,
    this.href,
  });

  String? type;
  Text? text;
  Annotations? annotations;
  String? plainText;
  dynamic? href;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        type: json["type"] == null ? null : json["type"],
        text: json["text"] == null ? null : Text.fromJson(json["text"]),
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

class Text {
  Text({
    this.content,
    this.link,
  });

  String? content;
  dynamic? link;

  factory Text.fromJson(Map<String, dynamic> json) => Text(
        content: json["content"] == null ? null : json["content"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "content": content == null ? null : content,
        "link": link,
      };
}

class Status {
  Status({
    this.id,
    this.type,
    this.select,
  });

  String? id;
  String? type;
  Select? select;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        select: json["select"] == null ? null : Select.fromJson(json["select"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "select": select == null ? null : select!.toJson(),
      };
}

class Select {
  Select({
    this.id,
    this.name,
    this.color,
  });

  String? id;
  String? name;
  String? color;

  factory Select.fromJson(Map<String, dynamic> json) => Select(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        color: json["color"] == null ? null : json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "color": color == null ? null : color,
      };
}
