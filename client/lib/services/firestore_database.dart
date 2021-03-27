import 'dart:async';

import 'package:women_mentor/models/booking.dart';
import 'package:women_mentor/models/interests.dart';
import 'package:women_mentor/models/user.dart';
import 'package:women_mentor/services/firestore_path.dart';
import 'package:women_mentor/services/firestore_service.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _service = FirestoreService.instance;

  Future<void> setUser(Map<String, dynamic> userData) => _service.setData(
      path: FirestorePath.user(uid), data: userData, merge: true);

  // Future<void> deleteJob(Job job) async {
  //   // delete where entry.jobId == job.jobId
  //   final allEntries = await entriesStream(job: job).first;
  //   for (final entry in allEntries) {
  //     if (entry.jobId == job.id) {
  //       await deleteEntry(entry);
  //     }
  //   }
  //   // delete job
  //   await _service.deleteData(path: FirestorePath.job(uid, job.id));
  // }
  //  Stream<AppUser> userStream() => _service.documentStream(
  //       path: FirestorePath.user(),
  //       builder: (data, documentId) => Interests.fromMap(data, documentId),
  //     );

  Stream<Interests> interestsStream() => _service.documentStream(
        path: FirestorePath.interests(),
        builder: (data, documentId) => Interests.fromMap(data, documentId),
      );

  // Stream<List<Job>> jobsStream() => _service.collectionStream(
  //       path: FirestorePath.jobs(uid),
  //       builder: (data, documentId) => Job.fromMap(data, documentId),
  //     );

  // Future<void> setEntry(Entry entry) => _service.setData(
  //       path: FirestorePath.entry(uid, entry.id),
  //       data: entry.toMap(),
  //     );

  // Future<void> deleteEntry(Entry entry) =>
  //     _service.deleteData(path: FirestorePath.entry(uid, entry.id));

  // Stream<List<Entry>> entriesStream({Job? job}) =>
  //     _service.collectionStream<Entry>(
  //       path: FirestorePath.entries(uid),
  //       queryBuilder: job != null
  //           ? (query) => query.where('jobId', isEqualTo: job.id)
  //           : null,
  //       builder: (data, documentID) => Entry.fromMap(data, documentID),
  //       sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
  //     );
  Stream<List<Booking>> bookingsStream() => _service.collectionStream(
        path: FirestorePath.bookings(),
        builder: (data, documentId) => Booking.fromData(data, documentId),
      );
  Stream<List<AppUser>> usersStream() => _service.collectionStream(
        path: FirestorePath.users(),
        builder: (data, documentId) => AppUser.fromData(data, documentId),
      );
}
