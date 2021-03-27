// can maybe extend mentee based on properties, but logically it doesn't make sense
class Mentor {
  final String goalStatement;
  final List<String> bookings;
  final List<String> availableTimes; // type not decided
  final String company;
  final String jobTitle;
  final int yearsOfExperience;
  final String id;

  Mentor({
    required this.id,
    required this.goalStatement,
    required this.company,
    required this.jobTitle,
    required this.yearsOfExperience,
    required this.availableTimes,
    this.bookings = const [],
  });

  factory Mentor.fromData(Map<String, dynamic>? data , String uid) {
    return Mentor(
        id: uid,
        goalStatement: data?['goalStatement'],
        bookings: data?['bookings'].map((e) => e),
        availableTimes: data?['availableTimes'],
        company: data?['company'],
        jobTitle: data?['jobTitle'],
        yearsOfExperience: data?['yearsOfExperience']);
  }

  Map<String, dynamic> toJson() {
    return {
      'goalStatement': goalStatement,
      'bookings': bookings,
      'availableTimes': availableTimes,
      'company': company,
      'jobTitle': jobTitle,
      'yearsOfExperience': yearsOfExperience
    };
  }
}
