import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:women_mentor/models/booking.dart';
import 'package:women_mentor/services/api.dart';

enum CallProvider { zoom, meet, skype }

final bookSessionViewModelProvider =
    ChangeNotifierProvider<BookSessionViewModel>((ref) {
  return BookSessionViewModel();
});

class BookSessionViewModel extends ChangeNotifier {
  bool isLoading = false;
  Timestamp? _meetingDate = Timestamp.fromDate(DateTime.now());
  Timestamp? get meetingDate => _meetingDate;

  String? _preferredCallProvider = '';
  String? get preferredCallProvider => _preferredCallProvider;

  String? _mentorId;
  String? get mentorId => _mentorId;

  List<String> meetingPurpose = [];

  CallProvider _callProvider = CallProvider.zoom;
  CallProvider get callProvider => _callProvider;

  ApiProvider apiProvider = ApiProvider();

  setCallProvider(CallProvider callProvider) {
    _callProvider = callProvider;
    notifyListeners();
  }

  setMeetingDate(DateTime meetingDate) {
    _meetingDate = Timestamp.fromDate(meetingDate);
    notifyListeners();
  }

  setPreferredCallProvider(String callProvider) {
    _preferredCallProvider = callProvider;
    notifyListeners();
  }

  setMentorID(String mentorId) {
    mentorId = mentorId;
    notifyListeners();
  }

  Future createBookingRequest({required String menteeId}) async {
    //   final firebaseAuth = context.read(firebaseAuthProvider);
    // final user = firebaseAuth.currentUser!;
    try {
      isLoading = true;
      notifyListeners();
      final booking = Booking(
        date: meetingDate!,
        menteeId: menteeId,
        mentorId: mentorId!,
        preferredCallProvider: preferredCallProvider!,
      );
      final response = await apiProvider.postBookingRequest(
          booking: booking, userID: menteeId);
      print(response);
    } catch (e) {
      throw e;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
