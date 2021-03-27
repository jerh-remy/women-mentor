import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String techLevel;
  final int? age;
  final String? ethnicity;
  final List<String>? hobbies;
  final List<String>? techInterests;
  // final Timestamp creationDate;

  AppUser({
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.email,
    required this.techLevel,
    this.hobbies = const [],
    this.techInterests = const [],
    this.ethnicity,
    this.age,
  });

  factory AppUser.fromData(Map<String, dynamic>? data, String uid) {
    return AppUser(
        id: uid,
        firstName: data?['firstName'],
        lastName: data?['lastName'],
        email: data?['email'],
        age: data?['age'],
        hobbies: data?['hobbies'],
        techInterests: data?['techInterests'],
        techLevel: data?['techLevel'],
        ethnicity: data?['ethnicity']);
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'firstName': firstName,
      'lastName': lastName,
      // 'email': email,
      'techLevel': techLevel,
      'age': age,
      'ethnicity': ethnicity,
      'creationDate': Timestamp.now(),
    };
  }
}
