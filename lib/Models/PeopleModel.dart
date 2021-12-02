import 'package:splitter/Models/ProductsModel.dart';

class PeopleList {
  List<People> people;
  List<Group> groups;
  PeopleList(this.people, this.groups);

  factory PeopleList.fromJson(dynamic json) {
    var peopleObjJson = json['Users'] as List;
    List<People> _people = peopleObjJson.map((tagJson) => People.fromJson(tagJson)).toList();
    return PeopleList(_people, []);
  }
}

class People {
  String email;
  String name;
  bool isUser;
  bool selected = false;
  num total = 0;
  List<Product> products = [];
  People(this.email, this.name, this.isUser);

  factory People.fromJson(dynamic json) {
    return People(json['email'] as String, json['name'] as String, true);
  }
}
class Group {
  String name;
  List<People> people;
  bool selected = false;
  Group(this.name, this.people);
}
