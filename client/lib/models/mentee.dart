class Mentee {
  final String goalStatement;
  final List<String> bookings;

  Mentee({
    required this.goalStatement,
    this.bookings = const [],
  });

  factory Mentee.fromData(Map<String, dynamic>? data /*, String uid*/) {
    return Mentee(
        // id: uid,
        goalStatement: data?['goalStatement'],
        bookings: data?['bookings'].map((e) => e),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'goalStatement': goalStatement,
      'bookings': bookings,
    };
  }
}
