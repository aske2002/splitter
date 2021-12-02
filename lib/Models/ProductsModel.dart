import 'package:splitter/Models/PeopleModel.dart';

class Products {
  List<Product> products;
  int length;
  num calcPrice;
  num recPrice;
  Products(this.products, this.length, this.calcPrice, this.recPrice);

  factory Products.fromJson(dynamic json) {
    var productObjJson = json['products'] as List;
    List<Product> _products = productObjJson.map((tagJson) => Product.fromJson(tagJson)).toList();
    return Products(_products, json['length'] as int, json['calcPrice'] as num, json['recPrice'] as num);
  }
}

class Product {
  String product;
  int amount;
  num price;
  num rabat;
  bool name;
  bool selected;
  bool mapped = false;
  List<People> people;
  Product(this.product, this.amount, this.price, this.rabat, this.name, this.selected);
  factory Product.fromJson(dynamic json) {
    print(json);
    return Product(json['product'] as String, json['amount'] as int, json['price'] as num, json['rabat'] as num, json['name'] as bool, false);
  }
}