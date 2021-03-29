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
  List<RankedMentor> data;

  factory RankedMentorsResponse.fromJson(Map<String, dynamic> json) =>
      RankedMentorsResponse(
        message: json["message"],
        data: List<RankedMentor>.from(
            json["data"].map((x) => RankedMentor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RankedMentor {
  RankedMentor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    this.offerStatement,
  });

  String id;
  String firstName;
  String lastName;
  String? jobTitle;
  String? offerStatement;

  factory RankedMentor.fromJson(Map<String, dynamic> json) {
    print(json["jobTitle"].runtimeType);
    return RankedMentor(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      jobTitle: json["jobTitle"],
      offerStatement: json["offerStatement"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "jobTitle": jobTitle == null ? null : jobTitle,
        "offerStatement": offerStatement == null ? null : offerStatement,
      };
}
