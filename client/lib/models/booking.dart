class Booking {
  final List<Booking>? changelog;
  final DateTime date;
  final String menteeId;
  final String mentorId;
  final String preferredCallProvider;
  final String? requesterId;
  final String? status;
  final String? id;
  final List<String> meetingPurpose;

  Booking({
    this.id,
    required this.date,
    required this.menteeId,
    required this.mentorId,
    required this.preferredCallProvider,
    this.requesterId,
    this.status,
    this.changelog = const [],
    this.meetingPurpose = const [],
  });

  factory Booking.fromData(Map<String, dynamic>? data, String uid) {
    return Booking(
      id: uid,
      changelog: List<Booking>.from(data?['changelog'].map((e) => e)),
      date: data?['date'],
      menteeId: data?['menteeId'],
      mentorId: data?['mentorId'],
      preferredCallProvider: data?['preferredCallProvider'],
      requesterId: data?['requesterId'],
      status: data?['status'],
      meetingPurpose: List<String>.from(data?['meetingPurpose'].map((e) => e)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toString().split(" ")[0],
      'menteeId': menteeId,
      'mentorId': mentorId,
      'preferredCallProvider': preferredCallProvider,
      // 'purpose': meetingPurpose.join(""),
      'purpose': meetingPurpose,
    };
  }
}
