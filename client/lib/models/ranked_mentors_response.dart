// To parse this JSON data, do
//
//     final rankedMentorsResponse = rankedMentorsResponseFromJson(jsonString);

import 'dart:convert';

RankedMentorsResponse rankedMentorsResponseFromJson(String str) =>
    RankedMentorsResponse.fromJson(json.decode(str));

String rankedMentorsResponseToJson(RankedMentorsResponse data) =>
    json.encode(data.toJson());

class RankedMentorsResponse {
  RankedMentorsResponse({
    required this.message,
    required this.data,
  });

  String message;
  List<String> data;

  factory RankedMentorsResponse.fromJson(Map<String, dynamic> json) =>
      RankedMentorsResponse(
        message: json["message"],
        data: List<String>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}
