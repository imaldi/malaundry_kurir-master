// To parse this JSON data, do
//
//     final cekNomorResponse = cekNomorResponseFromJson(jsonString);

import 'dart:convert';

import 'package:malaundry_kurir_flutter/data/model/account_model/account_model.dart';

CekNomorResponse cekNomorResponseFromJson(String str) => CekNomorResponse.fromJson(json.decode(str));

String cekNomorResponseToJson(CekNomorResponse data) => json.encode(data.toJson());

class CekNomorResponse {
  CekNomorResponse({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.limit,
    this.offset,
  });

  List<User> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;
  dynamic limit;
  int offset;

  factory CekNomorResponse.fromJson(Map<String, dynamic> json) => CekNomorResponse(
    data: json["data"] == null ? null : List<User>.from(json["data"].map((x) => User.fromJson(x))),
    draw: json["draw"],
    recordsTotal: json["recordsTotal"] == null ? null : json["recordsTotal"],
    recordsFiltered: json["recordsFiltered"] == null ? null : json["recordsFiltered"],
    limit: json["limit"],
    offset: json["offset"] == null ? null : json["offset"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "draw": draw,
    "recordsTotal": recordsTotal == null ? null : recordsTotal,
    "recordsFiltered": recordsFiltered == null ? null : recordsFiltered,
    "limit": limit,
    "offset": offset == null ? null : offset,
  };
}
