import 'PeopleModel.dart';
import 'ProductsModel.dart';

class SplitterList {
  List<People> participants;
  List<Group> groups;
  String name;
  List<Product> products;
  num calcPrice;
  num recPrice;
  int length;
  DateTime date = new DateTime.now();
  String description = "";
  SplitterList(this.name, this.participants, this.groups, this.products, this.calcPrice, this.recPrice, this.length);
}