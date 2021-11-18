/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Product type in your schema. */
@immutable
class Product extends Model {
  static const classType = const _ProductModelType();
  final String id;
  final String inqueryID;
  final String listID;
  final int amount;
  final double price;
  final double discount;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Product._internal(
      {@required this.id,
      @required this.inqueryID,
      @required this.listID,
      @required this.amount,
      @required this.price,
      @required this.discount});

  factory Product(
      {String id,
      @required String inqueryID,
      @required String listID,
      @required int amount,
      @required double price,
      @required double discount}) {
    return Product._internal(
        id: id == null ? UUID.getUUID() : id,
        inqueryID: inqueryID,
        listID: listID,
        amount: amount,
        price: price,
        discount: discount);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Product &&
        id == other.id &&
        inqueryID == other.inqueryID &&
        listID == other.listID &&
        amount == other.amount &&
        price == other.price &&
        discount == other.discount;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Product {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("inqueryID=" + "$inqueryID" + ", ");
    buffer.write("listID=" + "$listID" + ", ");
    buffer.write(
        "amount=" + (amount != null ? amount.toString() : "null") + ", ");
    buffer.write("price=" + (price != null ? price.toString() : "null") + ", ");
    buffer
        .write("discount=" + (discount != null ? discount.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Product copyWith(
      {String id,
      String inqueryID,
      String listID,
      int amount,
      double price,
      double discount}) {
    return Product(
        id: id ?? this.id,
        inqueryID: inqueryID ?? this.inqueryID,
        listID: listID ?? this.listID,
        amount: amount ?? this.amount,
        price: price ?? this.price,
        discount: discount ?? this.discount);
  }

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        inqueryID = json['inqueryID'],
        listID = json['listID'],
        amount = (json['amount'] as num)?.toInt(),
        price = (json['price'] as num)?.toDouble(),
        discount = (json['discount'] as num)?.toDouble();

  Map<String, dynamic> toJson() => {
        'id': id,
        'inqueryID': inqueryID,
        'listID': listID,
        'amount': amount,
        'price': price,
        'discount': discount
      };

  static final QueryField ID = QueryField(fieldName: "product.id");
  static final QueryField INQUERYID = QueryField(fieldName: "inqueryID");
  static final QueryField LISTID = QueryField(fieldName: "listID");
  static final QueryField AMOUNT = QueryField(fieldName: "amount");
  static final QueryField PRICE = QueryField(fieldName: "price");
  static final QueryField DISCOUNT = QueryField(fieldName: "discount");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Product";
    modelSchemaDefinition.pluralName = "Products";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Product.INQUERYID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Product.LISTID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Product.AMOUNT,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Product.PRICE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Product.DISCOUNT,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));
  });
}

class _ProductModelType extends ModelType<Product> {
  const _ProductModelType();

  @override
  Product fromJson(Map<String, dynamic> jsonData) {
    return Product.fromJson(jsonData);
  }
}
