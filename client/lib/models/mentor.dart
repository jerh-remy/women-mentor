// can maybe extend mentee based on properties, but logically it doesn't make sense
class Mentor {
  final String? goalStatement;
  final List<String>? bookings;
  final List<String>? preferredMenteeSkillLevels;
  final String? timeAvailability;
  final String? company;
  final String? jobTitle;
  final int? yearsOfExperience;
  final String id;

  Mentor({
    required this.id,
    required this.goalStatement,
    required this.company,
    required this.jobTitle,
    required this.yearsOfExperience,
    this.preferredMenteeSkillLevels = const [],
    this.timeAvailability,
    this.bookings = const [],
  });

  factory Mentor.fromData(Map<String, dynamic>? data, String uid) {
    data?.forEach((key, value) {
      print('$key: $value');
    });
    return Mentor(
        id: uid,
        goalStatement: data?['offerStatement'],
        bookings: data?['bookings'] == null
            ? []
            : List<String>.from(data?['bookings'].map((e) => e.toString())),
        timeAvailability: data?['timeCommitment'],
        company: data?['company'],
        jobTitle: data?['jobTitle'],
        preferredMenteeSkillLevels: List<String>.from(
            data?['preferredMenteeSkillLevel'].map((e) => e.toString())),
        yearsOfExperience: data?['yearsOfExperience']);
  }

  Map<String, dynamic> toJson() {
    return {
      'goalStatement': goalStatement,
      'bookings': bookings,
      'timeCommitment': timeAvailability,
      'company': company,
      'jobTitle': jobTitle,
      'yearsOfExperience': yearsOfExperience
    };
  }
}
