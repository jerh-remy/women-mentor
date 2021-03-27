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

  Future<void> completeProfileSetupAndOnboarding(
      FirestoreDatabase firestoreDatabase,
      {bool isMentorOnboarding = false}) async {
    try {
      await firestoreDatabase.setUser(
          {'hobbies': _selectedHobbies, 'interests': _selectedInterests});

      if (isMentorOnboarding) {
        print('write to mentor collection blah blah');
      }

      await _completeOnboarding();
    } catch (e) {
      throw e;
    }
  }
}
