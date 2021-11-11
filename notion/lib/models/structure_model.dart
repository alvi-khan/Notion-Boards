import 'dart:convert';

StructureModel structureModelFromJson(String str) =>
    StructureModel.fromJson(json.decode(str));

String structureModelToJson(StructureModel data) => json.encode(data.toJson());

class StructureModel {
  StructureModel({
    this.object,
    this.id,
    this.cover,
    this.icon,
    this.createdTime,
    this.lastEditedTime,
    this.title,
    this.properties,
    this.parent,
    this.url,
  });

  String? object;
  String? id;
  dynamic? cover;
  dynamic? icon;
  DateTime? createdTime;
  DateTime? lastEditedTime;
  List<Title>? title;
  Properties? properties;
  Parent? parent;
  String? url;

  factory StructureModel.fromJson(Map<String, dynamic> json) => StructureModel(
        object: json["object"] == null ? null : json["object"],
        id: json["id"] == null ? null : json["id"],
        cover: json["cover"],
        icon: json["icon"],
        createdTime: json["created_time"] == null
            ? null
            : DateTime.parse(json["created_time"]),
        lastEditedTime: json["last_edited_time"] == null
            ? null
            : DateTime.parse(json["last_edited_time"]),
        title: json["title"] == null
            ? null
            : List<Title>.from(json["title"].map((x) => Title.fromJson(x))),
        properties: json["properties"] == null
            ? null
            : Properties.fromJson(json["properties"]),
        parent: json["parent"] == null ? null : Parent.fromJson(json["parent"]),
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "object": object == null ? null : object,
        "id": id == null ? null : id,
        "cover": cover,
        "icon": icon,
        "created_time":
            createdTime == null ? null : createdTime!.toIso8601String(),
        "last_edited_time":
            lastEditedTime == null ? null : lastEditedTime!.toIso8601String(),
        "title": title == null
            ? null
            : List<dynamic>.from(title!.map((x) => x.toJson())),
        "properties": properties == null ? null : properties!.toJson(),
        "parent": parent == null ? null : parent!.toJson(),
        "url": url == null ? null : url,
      };
}

class Parent {
  Parent({
    this.type,
    this.pageId,
  });

  String? type;
  String? pageId;

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        type: json["type"] == null ? null : json["type"],
        pageId: json["page_id"] == null ? null : json["page_id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "page_id": pageId == null ? null : pageId,
      };
}

class Properties {
  Properties({
    this.status,
    this.assign,
    this.name,
  });

  Assign? status;
  Assign? assign;
  Assign? name;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        status: json["Status"] == null ? null : Assign.fromJson(json["Status"]),
        assign: json["Assign"] == null ? null : Assign.fromJson(json["Assign"]),
        name: json["Name"] == null ? null : Assign.fromJson(json["Name"]),
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
    this.name,
    this.type,
    this.people,
    this.title,
    this.select,
  });

  String? id;
  String? name;
  String? type;
  People? people;
  People? title;
  Select? select;

  factory Assign.fromJson(Map<String, dynamic> json) => Assign(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        people: json["people"] == null ? null : People.fromJson(json["people"]),
        title: json["title"] == null ? null : People.fromJson(json["title"]),
        select: json["select"] == null ? null : Select.fromJson(json["select"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "people": people == null ? null : people!.toJson(),
        "title": title == null ? null : title!.toJson(),
        "select": select == null ? null : select!.toJson(),
      };
}

class People {
  People();

  factory People.fromJson(Map<String, dynamic> json) => People();

  Map<String, dynamic> toJson() => {};
}

class Select {
  Select({
    this.options,
  });

  List<Option>? options;

  factory Select.fromJson(Map<String, dynamic> json) => Select(
        options: json["options"] == null
            ? null
            : List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "options": options == null
            ? null
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Option {
  Option({
    this.id,
    this.name,
    this.color,
  });

  String? id;
  String? name;
  String? color;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
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
