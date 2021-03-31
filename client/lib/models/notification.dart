// To parse this JSON data, do
//
//     final notification = notificationFromMap(jsonString);

import 'dart:convert';

AppNotification notificationFromMap(String str) =>
    AppNotification.fromMap(json.decode(str));

String notificationToMap(AppNotification data) => json.encode(data.toMap());

class AppNotification {
  AppNotification({
    required this.requesterUserProfile,
    required this.bookingData,
    required this.bookingId,
  });

  RequesterUserProfile requesterUserProfile;
  BookingData bookingData;
  String bookingId;

  factory AppNotification.fromMap(Map<String, dynamic> json) => AppNotification(
        requesterUserProfile:
            RequesterUserProfile.fromMap(json["requesterUserProfile"]),
        bookingData: BookingData.fromMap(json["bookingData"]),
        bookingId: json["bookingId"],
      );

  Map<String, dynamic> toMap() => {
        "requesterUserProfile": requesterUserProfile.toMap(),
        "bookingData": bookingData.toMap(),
        "bookingId": bookingId,
      };
}

class BookingData {
  BookingData({
    required this.mentorId,
    required this.menteeId,
    required this.date,
    required this.preferredCallProvider,
    required this.purpose,
    this.changelog = const [],
    required this.status,
    required this.requesterId,
  });

  String mentorId;
  String menteeId;
  DateTime date;
  String preferredCallProvider;
  List<String> purpose;
  List<dynamic>? changelog;
  String status;
  String requesterId;

  factory BookingData.fromMap(Map<String, dynamic> json) => BookingData(
        mentorId: json["mentorId"],
        menteeId: json["menteeId"],
        date: DateTime.parse(json["date"]),
        preferredCallProvider: json["preferredCallProvider"],
        purpose: List<String>.from(json["purpose"].map((x) => x)),
        changelog: List<dynamic>.from(json["changelog"].map((x) => x)),
        status: json["status"],
        requesterId: json["requesterId"],
      );

  Map<String, dynamic> toMap() => {
        "mentorId": mentorId,
        "menteeId": menteeId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "preferredCallProvider": preferredCallProvider,
        "purpose": List<dynamic>.from(purpose.map((x) => x)),
        "changelog": List<dynamic>.from(changelog!.map((x) => x)),
        "status": status,
        "requesterId": requesterId,
      };
}

class RequesterUserProfile {
  RequesterUserProfile({
    this.interests = const [],
    required this.age,
    required this.firstName,
    required this.ethnicity,
    required this.techLevel,
    required this.creationDate,
    this.hobbies = const [],
    required this.lastName,
    required this.isMentor,
  });

  List<String>? interests;
  int age;
  String firstName;
  String ethnicity;
  String techLevel;
  CreationDate creationDate;
  List<String>? hobbies;
  String lastName;
  bool isMentor;

  factory RequesterUserProfile.fromMap(Map<String, dynamic> json) =>
      RequesterUserProfile(
        interests: List<String>.from(json["interests"].map((x) => x)),
        age: json["age"],
        firstName: json["firstName"],
        ethnicity: json["ethnicity"],
        techLevel: json["techLevel"],
        creationDate: CreationDate.fromMap(json["creationDate"]),
        hobbies: List<String>.from(json["hobbies"].map((x) => x)),
        lastName: json["lastName"],
        isMentor: json["isMentor"],
      );

  Map<String, dynamic> toMap() => {
        "interests": List<dynamic>.from(interests!.map((x) => x)),
        "age": age,
        "firstName": firstName,
        "ethnicity": ethnicity,
        "techLevel": techLevel,
        "creationDate": creationDate.toMap(),
        "hobbies": List<dynamic>.from(hobbies!.map((x) => x)),
        "lastName": lastName,
        "isMentor": isMentor,
      };
}

class CreationDate {
  CreationDate({
    required this.seconds,
    required this.nanoseconds,
  });

  int seconds;
  int nanoseconds;

  factory CreationDate.fromMap(Map<String, dynamic> json) => CreationDate(
        seconds: json["_seconds"],
        nanoseconds: json["_nanoseconds"],
      );

  Map<String, dynamic> toMap() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
      };
}
