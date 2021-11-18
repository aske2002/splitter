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

/** This is an auto generated class representing the Inquery type in your schema. */
@immutable
class Inquery extends Model {
  static const classType = const _InqueryModelType();
  final String id;
  final String userName;
  final bool paid;
  final bool dismissed;
  final String listID;
  final List<Product> products;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Inquery._internal(
      {@required this.id,
      @required this.userName,
      @required this.paid,
      @required this.dismissed,
      @required this.listID,
      this.products});

  factory Inquery(
      {String id,
      @required String userName,
      @required bool paid,
      @required bool dismissed,
      @required String listID,
      List<Product> products}) {
    return Inquery._internal(
        id: id == null ? UUID.getUUID() : id,
        userName: userName,
        paid: paid,
        dismissed: dismissed,
        listID: listID,
        products:
            products != null ? List<Product>.unmodifiable(products) : products);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Inquery &&
        id == other.id &&
        userName == other.userName &&
        paid == other.paid &&
        dismissed == other.dismissed &&
        listID == other.listID &&
        DeepCollectionEquality().equals(products, other.products);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Inquery {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userName=" + "$userName" + ", ");
    buffer.write("paid=" + (paid != null ? paid.toString() : "null") + ", ");
    buffer.write("dismissed=" +
        (dismissed != null ? dismissed.toString() : "null") +
        ", ");
    buffer.write("listID=" + "$listID");
    buffer.write("}");

    return buffer.toString();
  }

  Inquery copyWith(
      {String id,
      String userName,
      bool paid,
      bool dismissed,
      String listID,
      List<Product> products}) {
    return Inquery(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        paid: paid ?? this.paid,
        dismissed: dismissed ?? this.dismissed,
        listID: listID ?? this.listID,
        products: products ?? this.products);
  }

  Inquery.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userName = json['userName'],
        paid = json['paid'],
        dismissed = json['dismissed'],
        listID = json['listID'],
        products = json['products'] is List
            ? (json['products'] as List)
                .map((e) => Product.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'paid': paid,
        'dismissed': dismissed,
        'listID': listID,
        'products': products?.map((Product? e) => e?.toJson()).toList()
      };

  static final QueryField ID = QueryField(fieldName: "inquery.id");
  static final QueryField USERNAME = QueryField(fieldName: "userName");
  static final QueryField PAID = QueryField(fieldName: "paid");
  static final QueryField DISMISSED = QueryField(fieldName: "dismissed");
  static final QueryField LISTID = QueryField(fieldName: "listID");
  static final QueryField PRODUCTS = QueryField(
      fieldName: "products",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Product).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Inquery";
    modelSchemaDefinition.pluralName = "Inqueries";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Inquery.USERNAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Inquery.PAID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Inquery.DISMISSED,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Inquery.LISTID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Inquery.PRODUCTS,
        isRequired: false,
        ofModelName: (Product).toString(),
        associatedKey: Product.INQUERYID));
  });
}

class _InqueryModelType extends ModelType<Inquery> {
  const _InqueryModelType();

  @override
  Inquery fromJson(Map<String, dynamic> jsonData) {
    return Inquery.fromJson(jsonData);
  }
}
