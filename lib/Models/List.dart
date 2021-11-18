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

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the List type in your schema. */
@immutable
class List extends Model {
  static const classType = const _ListModelType();
  final String id;
  final String name;
  final TemporalDateTime date;
  final List<Product> products;
  final List<Inquery> inqueries;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const List._internal(
      {@required this.id,
      @required this.name,
      @required this.date,
      this.products,
      this.inqueries});

  factory List(
      {String id,
      @required String name,
      @required TemporalDateTime date,
      List<Product> products,
      List<Inquery> inqueries}) {
    return List._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        date: date,
        products:
            products != null ? List<Product>.unmodifiable(products) : products,
        inqueries: inqueries != null
            ? List<Inquery>.unmodifiable(inqueries)
            : inqueries);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is List &&
        id == other.id &&
        name == other.name &&
        date == other.date &&
        DeepCollectionEquality().equals(products, other.products) &&
        DeepCollectionEquality().equals(inqueries, other.inqueries);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("List {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("date=" + (date != null ? date.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  List copyWith(
      {String id,
      String name,
      TemporalDateTime date,
      List<Product> products,
      List<Inquery> inqueries}) {
    return List(
        id: id ?? this.id,
        name: name ?? this.name,
        date: date ?? this.date,
        products: products ?? this.products,
        inqueries: inqueries ?? this.inqueries);
  }

  List.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        date = json['date'] != null
            ? TemporalDateTime.fromString(json['date'])
            : null,
        products = json['products'] is List
            ? (json['products'] as List)
                .map((e) => Product.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        inqueries = json['inqueries'] is List
            ? (json['inqueries'] as List)
                .map((e) => Inquery.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date?.format(),
        'products': products?.map((Product? e) => e?.toJson()).toList(),
        'inqueries': inqueries?.map((Inquery? e) => e?.toJson()).toList()
      };

  static final QueryField ID = QueryField(fieldName: "list.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField PRODUCTS = QueryField(
      fieldName: "products",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Product).toString()));
  static final QueryField INQUERIES = QueryField(
      fieldName: "inqueries",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Inquery).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "List";
    modelSchemaDefinition.pluralName = "Lists";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: List.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: List.DATE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: List.PRODUCTS,
        isRequired: false,
        ofModelName: (Product).toString(),
        associatedKey: Product.LISTID));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: List.INQUERIES,
        isRequired: false,
        ofModelName: (Inquery).toString(),
        associatedKey: Inquery.LISTID));
  });
}

class _ListModelType extends ModelType<List> {
  const _ListModelType();

  @override
  List fromJson(Map<String, dynamic> jsonData) {
    return List.fromJson(jsonData);
  }
}
