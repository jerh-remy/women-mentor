import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final String? techLevel;
  final int? age;
  final String? ethnicity;
  final List<String>? hobbies;
  final List<String>? techInterests;
  final bool? isMentor;
  // final Timestamp creationDate;

  AppUser({
    required this.firstName,
    required this.lastName,
    required this.id,
    this.email,
    required this.techLevel,
    this.hobbies = const [],
    this.techInterests = const [],
    this.ethnicity,
    this.age,
    this.isMentor = false,
  });

  factory AppUser.fromData(Map<String, dynamic>? data, String uid) {
    print(data?['hobbies'].runtimeType);
    data?.forEach((key, value) {
      print('$key: $value');
    });
    return AppUser(
        id: uid,
        firstName: data?['firstName'],
        lastName: data?['lastName'],
        email: data?['email'],
        age: data?['age'],
        hobbies: data?['hobbies'] == null
            ? []
            : List<String>.from(data?['hobbies'].map((e) => e.toString())),
        techInterests: data?['interests'] == null
            ? []
            : List<String>.from(data?['interests'].map((e) => e.toString())),
        techLevel: data?['techLevel'],
        ethnicity: data?['ethnicity'],
        isMentor:
            data?['isMentor']?.runtimeType == Null ? false : data?['isMentor']);
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
