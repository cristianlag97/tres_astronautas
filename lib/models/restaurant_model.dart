// To parse this JSON data, do
//
//     final restaurantData = restaurantDataFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class RestaurantData {
  RestaurantData({
    required this.data,
    required this.meta,
  });

  List<Datum> data;
  Meta meta;

  factory RestaurantData.fromJson(String str) => RestaurantData.fromMap(json.decode(str));

  factory RestaurantData.fromMap(Map<String, dynamic> json) => RestaurantData(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    meta: Meta.fromMap(json["meta"]),
  );

}

class Datum {
  Datum({
    required this.title,
    required this.images,
  });

  String title;
  Images images;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    title: json["title"],
    images: Images.fromMap(json["images"]),
  );
}


class Images {
  Images({
    required this.original,
  });

  FixedHeight original;

  factory Images.fromJson(String str) => Images.fromMap(json.decode(str));

  factory Images.fromMap(Map<String, dynamic> json) => Images(
      original: FixedHeight.fromMap(json["original"]),
  );
}

class FixedHeight {
  FixedHeight({
    required this.url,
  });

  String url;

  factory FixedHeight.fromJson(String str) => FixedHeight.fromMap(json.decode(str));

  factory FixedHeight.fromMap(Map<String, dynamic> json) => FixedHeight(
    url: json["url"],
  );

  Map<String, dynamic> toMap() => {
    "url": url,
  };
}



class Meta {
  Meta({
    required this.status,
    required this.msg,
    required this.responseId,
  });

  int status;
  String msg;
  String responseId;

  factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
      status: json["status"],
      msg: json["msg"],
      responseId: json["response_id"],
  );
}
