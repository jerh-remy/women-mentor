import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:women_mentor/models/booking.dart';
import 'package:women_mentor/services/api.dart';
import 'dart:convert';

enum CallProvider { zoom, meet, skype }

final bookSessionViewModelProvider =
    ChangeNotifierProvider.autoDispose<BookSessionViewModel>((ref) {
  return BookSessionViewModel();
});

class BookSessionViewModel extends ChangeNotifier {
  bool isLoading = false;
  DateTime? _meetingDate = DateTime.now();
  DateTime? get meetingDate => _meetingDate;

  String? _preferredCallProvider = '';
  String? get preferredCallProvider => _preferredCallProvider;

  String? _mentorId;
  String? get mentorId => _mentorId;

  List<String> meetingPurpose = [];

  CallProvider _callProvider = CallProvider.zoom;
  CallProvider get callProvider => _callProvider;

  ApiProvider apiProvider = ApiProvider();

  setMentorID(String mentorId) {
    print('MENTOR ID: $mentorId');

    _mentorId = mentorId;
    notifyListeners();
  }

  setCallProvider(CallProvider callProvider) {
    _callProvider = callProvider;
    notifyListeners();
  }

  setMeetingDate(DateTime meetingDate) {
    _meetingDate = meetingDate;
    notifyListeners();
  }

  setMeetingPurpose(List<String> purposeList) {
    if (meetingPurpose.isNotEmpty) {
      meetingPurpose.clear();
    }
    meetingPurpose.addAll([...purposeList]);
    notifyListeners();
  }

  String _getPreferredCallProviderString(CallProvider callProvider) {
    final String callProviderString;
    switch (callProvider) {
      case CallProvider.meet:
        callProviderString = 'meet';
        break;
      case CallProvider.zoom:
        callProviderString = 'zoom';
        break;
      case CallProvider.skype:
        callProviderString = 'skype';
        break;
      default:
        callProviderString = 'zoom';
    }
    return callProviderString;
  }

  Future createBookingRequest({required String menteeId}) async {
    print(_mentorId);
    print(menteeId);
    print(_callProvider);
    // print(json.encode(meetingPurpose));
    print(meetingDate.toString().split(" ")[0]);
    try {
      isLoading = true;
      notifyListeners();
      final booking = Booking(
        date: meetingDate!,
        menteeId: menteeId,
        mentorId: mentorId!,
        preferredCallProvider: _getPreferredCallProviderString(_callProvider),
        meetingPurpose: meetingPurpose,
      );
      final response = await apiProvider.postBookingRequest(
          booking: booking, userID: menteeId);
      print(response);
    } catch (e) {
      print(e);
      throw e;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
