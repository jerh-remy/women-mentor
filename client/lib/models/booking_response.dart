// To parse this JSON data, do
//
//     final bookingResponse = bookingResponseFromJson(jsonString);

import 'dart:convert';

BookingResponse bookingResponseFromJson(String str) =>
    BookingResponse.fromJson(json.decode(str));

String bookingResponseToJson(BookingResponse data) =>
    json.encode(data.toJson());

class BookingResponse {
  BookingResponse({
    required this.message,
    required this.data,
  });

  String message;
  Data data;

  factory BookingResponse.fromJson(Map<String, dynamic> json) =>
      BookingResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.mentorId,
    required this.menteeId,
    required this.date,
    required this.preferredCallProvider,
    required this.changelog,
    required this.status,
    required this.requesterId,
  });

  String mentorId;
  String menteeId;
  DateTime date;
  String preferredCallProvider;
  List<dynamic> changelog;
  String status;
  String requesterId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        mentorId: json["mentorId"],
        menteeId: json["menteeId"],
        date: DateTime.parse(json["date"]),
        preferredCallProvider: json["preferredCallProvider"],
        changelog: List<dynamic>.from(json["changelog"].map((x) => x)),
        status: json["status"],
        requesterId: json["requesterId"],
      );

  Map<String, dynamic> toJson() => {
        "mentorId": mentorId,
        "menteeId": menteeId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "preferredCallProvider": preferredCallProvider,
        "changelog": List<dynamic>.from(changelog.map((x) => x)),
        "status": status,
        "requesterId": requesterId,
      };
}
