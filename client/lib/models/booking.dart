import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final List<Booking> changelog;
  final Timestamp date;
  final String menteeId;
  final String mentorId;
  final String preferredCallProvider;
  final String requesterId;
  final String status;
  final String id;

  Booking({
    required this.id,
    required this.date,
    required this.menteeId,
    required this.mentorId,
    required this.preferredCallProvider,
    required this.requesterId,
    required this.status,
    this.changelog = const [],
  });

  factory Booking.fromData(Map<String, dynamic>? data, String uid) {
    return Booking(
        id: uid,
        changelog: data?['changelog'].map((e) => e),
        date: data?['date'],
        menteeId: data?['menteeId'],
        mentorId: data?['mentorId'],
        preferredCallProvider: data?['preferredCallProvider'],
        requesterId: data?['requesterId'],
        status: data?['status']);
  }

  // Shouldn't need this because bookings should only be created/ updated using /bookings endpoint
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'changelog': changelog,
      'date': date,
      'menteeId': menteeId,
      'mentorId': mentorId,
      'preferredCallProvider': preferredCallProvider,
      'requesterId': requesterId,
      'status': status
    };
  }
}
