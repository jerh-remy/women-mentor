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

  String _timeCommitment = '';
  String get timeCommitment => _timeCommitment;

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

  setTimeCommitment(String value) {
    _timeCommitment = value;
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
      await firestoreDatabase.setUser(
          {'hobbies': _selectedHobbies, 'interests': _selectedInterests});

      if (isMentorOnboarding) {
        print('write to mentor collection blah blah');
      }

      if (!isMentorOnboarding) {
        print('mentee specific write');
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
