import 'package:flutter/cupertino.dart';
import 'package:women_mentor/models/mentor.dart';
import 'package:women_mentor/models/user.dart';
import 'package:women_mentor/services/firestore_database.dart';
import 'package:rxdart/rxdart.dart';

class MentorAppUser {
  final String? goalStatement;
  final List<String>? bookings;
  final String? timeAvailability;
  final String? company;
  final String? jobTitle;
  final int? yearsOfExperience;
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final String? techLevel;
  final int? age;
  final String? ethnicity;
  final List<String>? hobbies;
  final List<String>? techInterests;
  final List<String>? preferredMenteeSkillLevels;
  final bool? isMentor;

  MentorAppUser(
      {this.goalStatement,
      this.bookings,
      this.timeAvailability,
      required this.company,
      required this.jobTitle,
      required this.yearsOfExperience,
      required this.id,
      required this.firstName,
      required this.lastName,
      this.email,
      required this.techLevel,
      this.age,
      this.ethnicity,
      this.hobbies,
      this.preferredMenteeSkillLevels,
      this.isMentor = false,
      this.techInterests});
}

class MentorProfileViewModel extends ChangeNotifier {
  MentorProfileViewModel({required this.database});
  final FirestoreDatabase database;

  Stream<MentorAppUser> mentorProfileStream(userId) =>
      CombineLatestStream.combine2(
        database.mentorStream(userId),
        database.userStream(userId),
        _mentorUserCombiner,
      );

  static MentorAppUser _mentorUserCombiner(Mentor mentor, AppUser appUser) {
    final mentorAppUser = MentorAppUser(
      company: mentor.company,
      jobTitle: mentor.jobTitle,
      yearsOfExperience: mentor.yearsOfExperience,
      id: appUser.id,
      firstName: appUser.firstName,
      lastName: appUser.lastName,
      techLevel: appUser.techLevel,
      hobbies: appUser.hobbies,
      techInterests: appUser.techInterests,
      ethnicity: appUser.ethnicity,
      goalStatement: mentor.goalStatement,
      isMentor: appUser.isMentor,
      timeAvailability: mentor.timeAvailability,
      preferredMenteeSkillLevels: mentor.preferredMenteeSkillLevels,
    );
    return mentorAppUser;
  }
}
