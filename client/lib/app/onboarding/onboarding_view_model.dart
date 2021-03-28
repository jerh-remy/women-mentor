import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:women_mentor/app/top_level_providers.dart';
import 'package:women_mentor/models/interests.dart';
import 'package:women_mentor/services/firestore_database.dart';
import 'package:women_mentor/services/shared_preferences_service.dart';

final onboardingViewModelProvider =
    ChangeNotifierProvider<OnboardingViewModel>((ref) {
  final sharedPreferencesService = ref.watch(sharedPreferencesServiceProvider);
  return OnboardingViewModel(sharedPreferencesService);
});

final interestsStreamProvider = StreamProvider.autoDispose<Interests>((ref) {
  final database = ref.watch(databaseProvider);
  return database.interestsStream();
});

class OnboardingViewModel extends ChangeNotifier {
  OnboardingViewModel(this.sharedPreferencesService) : super();
  final SharedPreferencesService sharedPreferencesService;

  bool get isOnboardingComplete =>
      sharedPreferencesService.isOnboardingComplete();

  Future<void> _completeOnboarding() async {
    await sharedPreferencesService.setOnboardingComplete();
    notifyListeners();
  }

  bool? checkboxValue = false;
  bool? checkboxValue2 = false;
  bool? checkboxValue3 = false;

  List<String> preferredMenteeSkillLevel = [];

  void setCheckBoxValue(bool? value, String menteeLevel) {
    checkboxValue = value!;
    if (value) {
      preferredMenteeSkillLevel.add(menteeLevel);
    } else {
      preferredMenteeSkillLevel
          .removeWhere((element) => element == menteeLevel);
    }
    notifyListeners();
  }

  void setCheckBoxValue2(bool? value, String menteeLevel) {
    checkboxValue2 = value!;
    if (value) {
      preferredMenteeSkillLevel.add(menteeLevel);
    } else {
      preferredMenteeSkillLevel
          .removeWhere((element) => element == menteeLevel);
    }
    notifyListeners();
  }

  void setCheckBoxValue3(bool? value, String menteeLevel) {
    checkboxValue3 = value!;
    if (value) {
      preferredMenteeSkillLevel.add(menteeLevel);
    } else {
      preferredMenteeSkillLevel
          .removeWhere((element) => element == menteeLevel);
    }
    notifyListeners();
  }

  List<String> values1 = ['10', '20', '30', '40'];
  List<String> values2 = ['Minutes', 'Hours', 'Day'];
  List<String> values3 = ['Week', 'Month'];
  late String value1;
  late String value2;
  late String value3;
  String get timeCommitmentAvailability => "$value1 $value2 per $value3";

  initialiseValues() {
    value1 = values1[0];
    value2 = values2[0];
    value3 = values3[0];
  }

  void setValue1(String value) {
    value1 = value;
    notifyListeners();
  }

  void setValue2(String value) {
    value2 = value;
    notifyListeners();
  }

  void setValue3(String value) {
    value3 = value;
    notifyListeners();
  }

  List<String> _selectedInterests = [];
  List<String> get selectedInterests => _selectedInterests;

  List<String> _selectedHobbies = [];
  List<String> get selectedHobbies => _selectedHobbies;

  List<String> _preferredMenteeSkillLevels = [];
  List<String> get preferredMenteeSkillLevels => _preferredMenteeSkillLevels;

  String _company = '';
  String get company => _company;

  String _jobTitle = '';
  String get jobTitle => _jobTitle;

  String _offerStatement = '';
  String get offerStatement => _offerStatement;

  int _yearsOfExperience = 0;
  int get yearsOfExperience => _yearsOfExperience;

  setCompany(String value) {
    _company = value;
    notifyListeners();
  }

  setJobTitle(String value) {
    _jobTitle = value;
    notifyListeners();
  }

  setOfferStatement(String value) {
    _offerStatement = value;
    notifyListeners();
  }

  setYearsOfExperience(int value) {
    _yearsOfExperience = value;
    notifyListeners();
  }

  addInterest(String interest) {
    if (_selectedInterests.length < 5) {
      _selectedInterests.add(interest);
      notifyListeners();
    }
  }

  removeInterest(String interest) {
    _selectedInterests.removeWhere((element) => element == interest);
    notifyListeners();
  }

  addHobby(String hobby) {
    if (_selectedHobbies.length < 5) {
      _selectedHobbies.add(hobby);
      notifyListeners();
    }
  }

  removeHobby(String hobby) {
    _selectedHobbies.removeWhere((element) => element == hobby);
    notifyListeners();
  }

  addPreferredMenteeSkillLevel(String skillLevel) {
    _preferredMenteeSkillLevels.add(skillLevel);
    notifyListeners();
  }

  removePreferredMenteeSkillLevel(String skillLevel) {
    _preferredMenteeSkillLevels.removeWhere((element) => element == skillLevel);
    notifyListeners();
  }

  Future<void> completeProfileSetupAndOnboarding(
      FirestoreDatabase firestoreDatabase,
      {bool isMentorOnboarding = false}) async {
    try {
      await firestoreDatabase.setUser({
        'hobbies': _selectedHobbies,
        'interests': _selectedInterests,
        'isMentor': isMentorOnboarding
      });

      if (isMentorOnboarding) {
        await firestoreDatabase.setMentor({
          'offerStatement': offerStatement,
          'company': company,
          'jobTitle': jobTitle,
          'yearsOfExperience': yearsOfExperience,
          'timeCommitment': timeCommitmentAvailability,
          'preferredMenteeSkillLevel': preferredMenteeSkillLevel,
        });
      } else {
        await firestoreDatabase.setMentee({'goalStatement': ''});
      }

      await _completeOnboarding();
    } catch (e) {
      throw e;
    } finally {
      _selectedHobbies = [];
      _selectedInterests = [];
      _preferredMenteeSkillLevels = [];
    }
  }
}
